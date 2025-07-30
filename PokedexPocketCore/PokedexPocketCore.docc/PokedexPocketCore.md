# ``PokedexPocketCore``

Core framework for PokedexPocket app providing shared networking, caching, and UI components.

## Overview

PokedexPocketCore is a Swift framework that provides the foundational components for the PokedexPocket iOS application. It contains shared functionality that can be reused across different feature modules, following proper modularization principles.

### Key Features

- **Networking Layer**: Complete HTTP networking solution built on Alamofire with RxSwift integration
- **Caching System**: Generic caching functionality with UserDefaults persistence
- **Shared UI Components**: Reusable UI components for consistent user experience
- **Extensions**: Utility extensions for common SwiftUI operations

### Architecture

The framework follows Clean Architecture principles with clear separation between:
- Network layer for API communication
- Data layer for local storage and caching
- UI components for presentation
- Extensions for utility functions

## Topics

### Networking

- ``NetworkService``
- ``NetworkServiceProtocol``
- ``APIEndpoint``
- ``NetworkConfiguration``
- ``AlamofireManager``
- ``NetworkError``

### Data Management

- ``CacheManager``
- ``CacheManagerProtocol``

### UI Components

- ``LoadingView``
- ``ErrorView``
- ``TypeBadge``
- ``SkillBadge``

### Extensions

- ``Color+Hex``
- ``View+CornerRadius``

### Dependencies

This framework requires the following external dependencies:
- **Alamofire**: For HTTP networking capabilities
- **RxSwift**: For reactive programming patterns

Add these to your Package.swift:
```swift
dependencies: [
    .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.0"),
    .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.5.0")
]
```