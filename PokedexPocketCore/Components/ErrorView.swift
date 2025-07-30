//
//  ErrorView.swift
//  PokedexPocket
//
//  Created by Azri on 26/07/25.
//

import SwiftUI

public struct ErrorView: View {
    let error: Error
    let onRetry: () -> Void

    public init(error: Error, onRetry: @escaping () -> Void) {
        self.error = error
        self.onRetry = onRetry
    }

    public var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundColor(.orange)

            VStack(spacing: 8) {
                Text("Oops! Something went wrong")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Text(error.localizedDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            Button(action: onRetry) {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.clockwise")
                        .font(.subheadline)
                    Text("Try Again")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.blue)
                .cornerRadius(12)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(32)
    }
}

public struct NetworkErrorView: View {
    let onRetry: () -> Void

    public init(onRetry: @escaping () -> Void) {
        self.onRetry = onRetry
    }

    public var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 48))
                .foregroundColor(.red)

            VStack(spacing: 8) {
                Text("No Internet Connection")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Text("Please check your internet connection and try again.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            Button(action: onRetry) {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.clockwise")
                        .font(.subheadline)
                    Text("Retry")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.blue)
                .cornerRadius(12)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(32)
    }
}

#Preview("Error View") {
    ErrorView(
        error: NSError(
            domain: "TestError",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "This is a sample error message for preview purposes."]
        )
    ) {
        print("Retry tapped")
    }
}

#Preview("Network Error View") {
    NetworkErrorView {
        print("Retry tapped")
    }
}