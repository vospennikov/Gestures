## Gestures
![Swift](https://img.shields.io/badge/Swift-5.7.1-orange?style=flat)
![Platform](https://img.shields.io/badge/platform-iOS%2013%20%7C%20macOS%2011-orange)
![Framework](https://img.shields.io/badge/Framework-SwiftUI-orange)
![Package Manager](https://img.shields.io/badge/Package%20Manager-SPM%20%7C%20Cocoapods-orange)
![GitHub](https://img.shields.io/badge/Licence-MIT-orange)
![Demo](Images/demo.gif)

Before iOS 16 and macOS 13, SwiftUI didn't return the gesture location. It is a lightweight open-source extension to SwiftUI's gesture API.

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
.package(url: "https://github.com/vospennikov/Gestures.git", .upToNextMinor(from: "1.0.5"))
```
### Cocoapods
Gestures is available through CocoaPods. To install it, simply add the following line to your Podfile:
```ruby
pod 'Gestures', '1.0.5'
```
## Documentation

The documentation for releases and `main` are available here:

* [`main`](https://vospennikov.github.io/Gestures/main/documentation/gestures)
* [1.0.4](https://vospennikov.github.io/Gestures/1.0.4/documentation/gestures)

## License
Gestures is available under the MIT license. See the LICENSE file for more info.
