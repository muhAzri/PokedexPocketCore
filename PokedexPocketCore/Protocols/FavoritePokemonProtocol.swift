//
//  FavoritePokemonProtocol.swift
//  PokedexPocketCore
//
//  Created by Azri on 31/07/25.
//

import Foundation

// MARK: - Protocol for Pokemon that can be favorited
public protocol FavoritePokemonProtocol {
    var id: Int { get }
    var name: String { get }
    var primaryType: String { get }
    var imageURL: String { get }
}

// MARK: - Default implementations for common properties
public extension FavoritePokemonProtocol {
    var formattedName: String {
        name.capitalized
    }
    
    var pokemonNumber: String {
        String(format: "#%03d", id)
    }
}