//
//  PokedexPocketCore.swift
//  PokedexPocketCore
//
//  Created by Azri on 30/07/25.
//

import Foundation
import SwiftUI
import Alamofire
import RxSwift

// MARK: - Framework Version Info
public struct PokedexPocketCore {
    public static let version = "1.0.0"
    public static let buildNumber = "1"
    
    public static var frameworkInfo: String {
        return "PokedexPocketCore v\(version) (\(buildNumber))"
    }
}

