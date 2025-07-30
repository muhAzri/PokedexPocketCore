//
//  PokemonEndpoints.swift
//  PokedexPocketCore
//
//  Created by Azri on 26/07/25.
//

import Foundation
import Alamofire

public enum PokemonEndpoint: APIEndpoint {
    case pokemonList(offset: Int, limit: Int)
    case pokemonDetail(id: Int)
    case pokemonDetailByURL(url: String)

    public var path: String {
        switch self {
        case .pokemonList:
            return "/pokemon"
        case .pokemonDetail(let id):
            return "/pokemon/\(id)"
        case .pokemonDetailByURL:
            return ""
        }
    }

    public var method: HTTPMethod {
        return .get
    }

    public var parameters: Parameters? {
        switch self {
        case .pokemonList(let offset, let limit):
            return [
                "offset": offset,
                "limit": limit
            ]
        case .pokemonDetail, .pokemonDetailByURL:
            return nil
        }
    }

    public func url(baseURL: String) -> String {
        switch self {
        case .pokemonDetailByURL(let url):
            return url
        default:
            return baseURL + path
        }
    }
}