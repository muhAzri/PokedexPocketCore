//
//  CacheManagerTests.swift
//  PokedexPocketTests
//
//  Created by Azri on 27/07/25.
//

import XCTest
@testable import PokedexPocket_Core

final class CacheManagerTests: XCTestCase {
    var sut: CacheManager!
    
    override func setUp() {
        super.setUp()
        sut = CacheManager.shared
        sut.clear()
    }
    
    override func tearDown() {
        sut.clear()
        sut = nil
        super.tearDown()
    }
    
    func testCacheSetAndGet() {
        let testString = "Test String"
        let key = "test_key"
        
        sut.set(testString, forKey: key)
        let retrievedString = sut.get(key, type: String.self)
        
        XCTAssertEqual(retrievedString, testString)
    }
    
    func testCacheSetAndGetComplexObject() {
        struct TestObject: Codable, Equatable {
            let id: Int
            let name: String
        }
        
        let testObject = TestObject(id: 1, name: "Test")
        let key = "test_object_key"
        
        sut.set(testObject, forKey: key)
        let retrievedObject = sut.get(key, type: TestObject.self)
        
        XCTAssertEqual(retrievedObject, testObject)
    }
    
    func testCacheGetNonExistentKey() {
        let result = sut.get("non_existent_key", type: String.self)
        XCTAssertNil(result)
    }
    
    func testCacheRemove() {
        let testString = "Test String"
        let key = "test_key"
        
        sut.set(testString, forKey: key)
        sut.remove(key)
        let retrievedString = sut.get(key, type: String.self)
        
        XCTAssertNil(retrievedString)
    }
    
    func testCacheValidation() {
        let testString = "Test String"
        let key = "test_key"
        
        sut.set(testString, forKey: key)
        
        let isValid = sut.isCacheValid(forKey: key, maxAge: 3600)
        XCTAssertTrue(isValid)
        
        let isInvalid = sut.isCacheValid(forKey: key, maxAge: -1)
        XCTAssertFalse(isInvalid)
    }
    
    func testCacheValidationNonExistentKey() {
        let isValid = sut.isCacheValid(forKey: "non_existent", maxAge: 3600)
        XCTAssertFalse(isValid)
    }
    
    func testCacheClear() {
        let testString1 = "Test String 1"
        let testString2 = "Test String 2"
        let key1 = "test_key_1"
        let key2 = "test_key_2"
        
        sut.set(testString1, forKey: key1)
        sut.set(testString2, forKey: key2)
        
        sut.clear()
        
        let result1 = sut.get(key1, type: String.self)
        let result2 = sut.get(key2, type: String.self)
        
        XCTAssertNil(result1)
        XCTAssertNil(result2)
    }
}