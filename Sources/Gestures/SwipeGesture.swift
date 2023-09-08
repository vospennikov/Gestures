//
//  SwipeGesture.swift
//  Gestures
//
//  Created by Mikhail Vospennikov on 13.12.2022.
//

import SwiftUI

public struct SwipeGesture: ViewModifier {
    /// The possible directions of a swipe gesture.
    public enum Direction {
        case down
        case up
        case right
        case left
        case unknown
    }

    /// The minimum distance the user needs to swipe for the gesture to be recognised.
    public var minimumDistance: CGFloat

    /// The coordinate space in which the gesture is recognised.
    public var coordinateSpace: CoordinateSpace

    /// A closure that is called when the swipe gesture changes.
    /// - Parameters:
    ///   - direction: The direction of the swipe gesture.
    ///   - location: The current location of the gesture in the coordinate space.
    public var onChanged: (Direction, CGPoint) -> Void

    /// A closure that is called when the swipe gesture ends.
    /// - Parameters:
    ///   - direction: The direction of the swipe gesture.
    ///   - location: The final location of the gesture in the coordinate space.
    public var onEnded: (Direction, CGPoint) -> Void

    /// Initialises a swipe gesture modifier with the specified parameters.
    /// - Parameters:
    ///   - minimumDistance: The minimum distance the user needs to swipe for the gesture to be recognised.
    ///   - coordinateSpace: The coordinate space in which the gesture is recognised.
    ///   - onChanged: A closure that is called when the swipe gesture changes.
    ///   - onEnded: A closure that is called when the swipe gesture ends.
    public init(
        minimumDistance: CGFloat,
        coordinateSpace: CoordinateSpace,
        onChanged: @escaping (Direction, CGPoint) -> Void,
        onEnded: @escaping (Direction, CGPoint) -> Void
    ) {
        self.minimumDistance = minimumDistance
        self.coordinateSpace = coordinateSpace
        self.onChanged = onChanged
        self.onEnded = onEnded
    }

    public func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture(minimumDistance: minimumDistance, coordinateSpace: coordinateSpace)
                    .onChanged { value in
                        onChanged(calculateDirection(translation: value.translation), value.location)
                    }
                    .onEnded { value in
                        onEnded(calculateDirection(translation: value.translation), value.location)
                    }
            )
    }

    private func calculateDirection(translation: CGSize) -> Direction {
        let direction = atan2(translation.width, translation.height)
        switch direction {
        case -Double.pi / 4..<Double.pi / 4:
            return .down
        case Double.pi / 4..<Double.pi * 3 / 4:
            return .right
        case Double.pi * 3 / 4...Double.pi,
             -Double.pi..<(-Double.pi * 3 / 4):
            return .up
        case -Double.pi * 3 / 4..<(-Double.pi / 4):
            return .left
        default:
            return .unknown
        }
    }
}

public extension View {
    /// Adds swipe gesture recognition to the view.
    /// - Parameters:
    ///   - minimumDistance: The minimum distance the user needs to swipe for the gesture to be recognised (default:
    /// 10).
    ///   - coordinateSpace: The coordinate space in which the gesture is recognised (default: .local).
    ///   - onChanged(direction, location): A closure that is called when the swipe gesture changes.
    ///   - onEnded(direction, location): A closure that is called when the swipe gesture ends.
    /// - Returns: A modified view with the swipe gesture recognition.
    func onSwipeGesture(
        minimumDistance: CGFloat = 10,
        coordinateSpace: CoordinateSpace = .local,
        onChanged: @escaping (SwipeGesture.Direction, CGPoint) -> Void = { _, _ in },
        onEnded: @escaping (SwipeGesture.Direction, CGPoint) -> Void = { _, _ in }
    ) -> some View {
        modifier(
            SwipeGesture(
                minimumDistance: minimumDistance,
                coordinateSpace: coordinateSpace,
                onChanged: onChanged,
                onEnded: onEnded
            )
        )
    }
}
