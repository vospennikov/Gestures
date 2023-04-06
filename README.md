## Gestures
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
