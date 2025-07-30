//
//  NetworkService.swift
//  PokedexPocket
//
//  Created by Azri on 26/07/25.
//

import Foundation
import Alamofire
import RxSwift

public protocol NetworkServiceProtocol {
    func request<T: Codable>(_ endpoint: APIEndpoint, responseType: T.Type) -> Observable<T>
}

public class NetworkService: NetworkServiceProtocol {
    private let session: Session
    private let configuration: NetworkConfiguration

    public init(configuration: NetworkConfiguration) {
        self.configuration = configuration
        self.session = AlamofireManager.shared.session
    }

    public func request<T: Codable>(_ endpoint: APIEndpoint, responseType: T.Type) -> Observable<T> {
        return Observable.create { observer in
            let request = self.session.request(
                endpoint.url(baseURL: self.configuration.baseURL),
                method: endpoint.method,
                parameters: endpoint.parameters,
                encoding: endpoint.encoding,
                headers: endpoint.headers
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(NetworkError.from(afError: error))
                }
            }

            return Disposables.create {
                request.cancel()
            }
        }
        .retry(configuration.maxRetryAttempts)
    }
}

public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError(Error)
    case networkError(Error)
    case serverError(Int)
    case unknown

    public static func from(afError: AFError) -> NetworkError {
        switch afError {
        case .invalidURL:
            return .invalidURL
        case .responseValidationFailed(let reason):
            if case .unacceptableStatusCode(let code) = reason {
                return .serverError(code)
            }
            return .networkError(afError)
        case .responseSerializationFailed(let reason):
            if case .decodingFailed(let error) = reason {
                return .decodingError(error)
            }
            return .networkError(afError)
        default:
            return .networkError(afError)
        }
    }

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode response"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .serverError(let code):
            return "Server error with code: \(code)"
        case .unknown:
            return "Unknown error occurred"
        }
    }
}