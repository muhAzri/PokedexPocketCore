//
//  CacheManager.swift
//  PokedexPocket
//
//  Created by Azri on 27/07/25.
//

import Foundation

public protocol CacheManagerProtocol {
    func get<T: Codable>(_ key: String, type: T.Type) -> T?
    func set<T: Codable>(_ object: T, forKey key: String)
    func remove(_ key: String)
    func clear()
    func isCacheValid(forKey key: String, maxAge: TimeInterval) -> Bool
}

public final class CacheManager: CacheManagerProtocol {
    public static let shared = CacheManager()

    private let userDefaults = UserDefaults.standard
    private let cacheTimeKey = "cache_time_"

    private init() {}

    public func get<T: Codable>(_ key: String, type: T.Type) -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }

        do {
            let object = try JSONDecoder().decode(type, from: data)
            return object
        } catch {
            return nil
        }
    }

    public func set<T: Codable>(_ object: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(object)
            userDefaults.set(data, forKey: key)
            userDefaults.set(Date().timeIntervalSince1970, forKey: cacheTimeKey + key)
        } catch {
        }
    }

    public func remove(_ key: String) {
        userDefaults.removeObject(forKey: key)
        userDefaults.removeObject(forKey: cacheTimeKey + key)
    }

    public func clear() {
        let keys = userDefaults.dictionaryRepresentation().keys
        for key in keys where key.hasPrefix(cacheTimeKey) {
            let originalKey = String(key.dropFirst(cacheTimeKey.count))
            remove(originalKey)
        }
    }

    public func isCacheValid(forKey key: String, maxAge: TimeInterval) -> Bool {
        let cacheTime = userDefaults.double(forKey: cacheTimeKey + key)
        guard cacheTime > 0 else { return false }

        let age = Date().timeIntervalSince1970 - cacheTime
        return age < maxAge
    }
}

// MARK: - Cache Keys
public extension CacheManager {
    enum CacheKey {
        public static let pokemonList = "pokemon_list"
        public static let pokemonDetail = "pokemon_detail_"
    }

    enum CacheMaxAge {
        public static let pokemonList: TimeInterval = 24 * 60 * 60 // 24 hours
        public static let pokemonDetail: TimeInterval = 7 * 24 * 60 * 60 // 7 days
    }
}