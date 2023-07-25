//
//  TouchGesture.swift
//  Gestures
//
//  Created by Mikhail Vospennikov on 26.12.2022.
//

import SwiftUI

public struct TouchGesture: ViewModifier {
    /// The number of touches required for the gesture to be recognised.
    public var count: Int
    
    /// The coordinate space in which the gesture is recognised.
    public var coordinateSpace: CoordinateSpace
    
    /// A closure that is called when the touch gesture ends.
    public var onEnded: (Value) -> Void
    
    /// The value representing the touch gesture.
    public struct Value: Equatable {
        /// The location of the touch gesture in the coordinate space.
        public var location: CGPoint
        
        public static func == (a: TouchGesture.Value, b: TouchGesture.Value) -> Bool {
            a.location == b.location
        }
    }
    
    public func body(content: Content) -> some View {
        content.gesture(tapGesture)
    }
    
    private var tapGesture: some Gesture {
        if #available(iOS 16.0, *),
           #available(macOS 13.0, *) {
            return SpatialTapGesture(count: count)
                .onEnded { gesture in
                    onEnded(.init(location: gesture.location))
                }
        } else {
            return SequenceGesture(
                TapGesture(count: count),
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded { gesture in
                        guard gesture.contains(gesture.location) else {
                            return
                        }
                        onEnded(.init(location: gesture.location))
                    }
            )
        }
    }
}

fileprivate extension DragGesture.Value {
    func contains(_ location: CGPoint) -> Bool {
        guard ((startLocation.x - 1)...(startLocation.x + 1)).contains(location.x),
              ((startLocation.y - 1)...(startLocation.y + 1)).contains(location.y) else {
            return false
        }
        return true
    }
}

public extension View {
    /// Adds touch gesture recognition to the view.
    /// - Parameters:
    ///   - count: The number of touches required for the gesture to be recognised (default: 1).
    ///   - coordinateSpace: The coordinate space in which the gesture is recognised (default: .local).
    ///   - onEnded(gestureValue): A closure that is called when the touch gesture ends and representing the touch gesture value.
    /// - Returns: A modified view with the touch gesture recognition.
    func onTouchGesture(
        count: Int = 1,
        coordinateSpace: CoordinateSpace = .local,
        onEnded: @escaping (TouchGesture.Value) -> Void = { _ in }
    ) -> some View {
        modifier(
            TouchGesture(count: count, coordinateSpace: coordinateSpace, onEnded: onEnded)
        )
    }
}
