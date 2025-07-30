# PokedexPocketCore

A Swift framework providing core networking, caching, and UI components for the PokedexPocket iOS application.

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org/)
[![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)](https://developer.apple.com/ios/)
[![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)](https://developer.apple.com/ios/)

## Overview

PokedexPocketCore is a modular Swift framework that provides foundational components for iOS applications. It encapsulates shared functionality including networking, data caching, UI components, and utility extensions following Clean Architecture principles.

## Features

### 🌐 Networking Layer
- **NetworkService**: HTTP client built on Alamofire with RxSwift integration
- **APIEndpoint**: Protocol-based endpoint definitions
- **NetworkConfiguration**: Environment-based configuration management
- **AlamofireManager**: Session management with custom interceptors
- **NetworkError**: Comprehensive error handling

### 💾 Data Management
- **CacheManager**: Generic caching system with UserDefaults persistence
- **Cache expiration policies**: Configurable TTL for different data types
- **Type-safe caching**: Generic implementation for any Codable type

### 🎨 UI Components
- **LoadingView**: Elegant loading indicators with shimmer effects
- **ErrorView**: Consistent error state displays with retry functionality
- **TypeBadge & SkillBadge**: Reusable badge components with dynamic styling
- **Shimmer Effects**: Advanced shimmer animations for loading states

### 🔧 Extensions
- **Color+Hex**: Hex color initialization for SwiftUI
- **View+CornerRadius**: Custom corner radius modifiers
- **Additional utility extensions**: Common functionality extensions

## Installation

### Swift Package Manager

Add PokedexPocket-Core to your project using Swift Package Manager:

```swift
dependencies: [
    .package(path: "../PokedexPocket-Core")
]
```

### Manual Integration

1. Clone or download the framework
2. Drag `PokedexPocket-Core.xcodeproj` into your project
3. Add the framework to your target's dependencies

## Requirements

- **iOS**: 17.0+
- **Xcode**: 15.0+
- **Swift**: 5.9+

### Dependencies

```swift
dependencies: [
    .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.0"),
    .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.5.0")
]
```

## Quick Start

### Import the Framework

```swift
import PokedexPocket_Core
```

### Basic Usage

#### Networking

```swift
// Configure network service
let config = NetworkConfiguration.loadFromEnvironment()
let networkService = NetworkService(configuration: config)

// Make API requests
networkService.request(endpoint, responseType: MyModel.self)
    .subscribe(
        onNext: { response in
            // Handle success
        },
        onError: { error in
            // Handle error
        }
    )
    .disposed(by: disposeBag)
```

#### Caching

```swift
// Cache data
let cacheManager = CacheManager.shared
cacheManager.set(myObject, forKey: "my_key")

// Retrieve cached data
if let cachedObject = cacheManager.get("my_key", type: MyModel.self) {
    // Use cached data
}

// Check cache validity
if cacheManager.isCacheValid(forKey: "my_key", maxAge: 3600) {
    // Cache is still valid
}
```

#### UI Components

```swift
import SwiftUI

struct MyView: View {
    var body: some View {
        VStack {
            // Loading view
            LoadingView()
            
            // Error view with retry
            ErrorView(error: myError) {
                // Retry action
            }
            
            // Type badge
            TypeBadge(type: "fire", color: .red)
            
            // Skill badge
            SkillBadge(skill: "Swift", color: .blue)
        }
    }
}
```

#### Extensions

```swift
// Hex colors
Color(hex: "FF5733")

// Custom corner radius
MyView()
    .cornerRadius(12, corners: [.topLeft, .topRight])
```

## Architecture

The framework follows Clean Architecture principles with clear separation of concerns:

```
PokedexPocket-Core/
├── Network/                    # Networking layer
│   ├── Services/              # Core network services
│   ├── Endpoints/             # API endpoint definitions
│   ├── NetworkConfiguration.swift
│   └── AlamofireManager.swift
├── Data/                      # Data management
│   └── CacheManager.swift
├── Components/                # Reusable UI components
│   ├── LoadingView.swift
│   ├── ErrorView.swift
│   ├── TypeBadge.swift
│   └── SkillBadge.swift
├── Extensions/                # Utility extensions
│   ├── Color+Hex.swift
│   └── View+CornerRadius.swift
└── PokedexPocket_Core.swift  # Main framework export
```

## API Reference

### NetworkService

```swift
public protocol NetworkServiceProtocol {
    func request<T: Codable>(_ endpoint: APIEndpoint, responseType: T.Type) -> Observable<T>
}

public class NetworkService: NetworkServiceProtocol {
    public init(configuration: NetworkConfiguration)
    public func request<T: Codable>(_ endpoint: APIEndpoint, responseType: T.Type) -> Observable<T>
}
```

### CacheManager

```swift
public protocol CacheManagerProtocol {
    func get<T: Codable>(_ key: String, type: T.Type) -> T?
    func set<T: Codable>(_ object: T, forKey key: String)
    func remove(_ key: String)
    func clear()
    func isCacheValid(forKey key: String, maxAge: TimeInterval) -> Bool
}

public final class CacheManager: CacheManagerProtocol {
    public static let shared: CacheManager
}
```

### UI Components

```swift
public struct LoadingView: View {
    public var body: some View
}

public struct ErrorView: View {
    public init(error: Error, onRetry: @escaping () -> Void)
    public var body: some View
}

public struct TypeBadge: View {
    public init(type: String, color: Color)
    public var body: some View
}
```

## Development

### Building the Framework

```bash
# Open the framework project
open PokedexPocket-Core.xcodeproj

# Build via command line
xcodebuild -scheme PokedexPocket-Core build
```

### Running Tests

```bash
# Run unit tests
xcodebuild test -scheme PokedexPocket-Core

# Run with coverage
xcodebuild test -scheme PokedexPocket-Core -enableCodeCoverage YES
```

### Code Quality

The framework uses SwiftLint for code quality enforcement:

```bash
# Run SwiftLint
swiftlint lint

# Auto-fix issues
swiftlint --fix
```

## Contributing

### Guidelines

1. **Shared Functionality Only**: Only add truly shared components that can be reused across multiple modules
2. **Public APIs**: Ensure all public APIs are properly exported in `PokedexPocket_Core.swift`
3. **Documentation**: Update documentation for new public APIs
4. **Testing**: Add comprehensive tests for new functionality
5. **Backward Compatibility**: Maintain backward compatibility for existing APIs

### Code Style

- Follow Swift API Design Guidelines
- Use meaningful, descriptive names
- Add comprehensive documentation comments
- Maintain consistent code formatting

### Pull Requests

1. Create feature branch from `main`
2. Implement changes with tests
3. Update documentation
4. Ensure all tests pass
5. Create pull request with clear description

## Error Handling

The framework provides comprehensive error handling:

```swift
public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError(Error)
    case networkError(Error)
    case serverError(Int)
    case unknown
    
    public var errorDescription: String? { ... }
    public static func from(afError: AFError) -> NetworkError { ... }
}
```

## Performance Considerations

### Caching Strategy
- **Memory Efficiency**: Uses UserDefaults for persistent caching
- **Cache Invalidation**: Automatic expiration based on configurable TTL
- **Type Safety**: Generic implementation prevents type mismatches

### Network Optimization
- **Connection Management**: Reuses HTTP connections through Alamofire
- **Request Retry**: Automatic retry with exponential backoff
- **Error Recovery**: Graceful error handling and recovery

## Version History

### 1.0.0
- Initial release
- Core networking functionality
- Basic caching system
- Essential UI components
- Utility extensions

## License

This framework is part of the PokedexPocket project and follows the same MIT License.

## Support

For issues, questions, or contributions related to PokedexPocket-Core:

- **Issues**: Create an issue in the main PokedexPocket repository
- **Documentation**: Refer to the framework's DocC documentation
- **Email**: muhazri.dev@gmail.com

---

*PokedexPocket-Core - Shared foundation for iOS excellence* ⚡