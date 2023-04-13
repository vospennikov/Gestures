## Gestures
![Swift](https://img.shields.io/badge/Swift-5.8-orange?style=flat)
![Platforms](https://img.shields.io/badge/platform-iOS%2013-orange?style=flat)
![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat)
![GitHub](https://img.shields.io/badge/licence-MIT-orange)
![Demo](Images/demo.gif)

Before iOS 16, SwiftUI didn't return gesture location. This is a lightweight extension to SwiftUI's gesture API. 

## Usage
```swift
Rectangle()
  .onTouchGesture(count: 1) { gesture in
    print(gesture.location)
  }
  .onSwipeGesture(minimumDistance: 15.0, coordinateSpace: .local) { direction, location in
    print(direction, location)
  } onEnded: { direction, location in
    print(direction, location)
  }
```

## Installation
### Swift Package Manager
Add the following dependency to your **Package.swift** file:
```swift
.package(url: "https://github.com/vospennikov/Gestures.git", .upToNextMinor(from: "1.0.3"))
```

## License
Gestures is available under the MIT license. See the LICENSE file for more info.
