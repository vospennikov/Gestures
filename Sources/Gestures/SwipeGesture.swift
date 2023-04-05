//
//  SwipeGesture.swift
//  Gestures
//
//  Created by Mikhail Vospennikov on 13.12.2022.
//

import SwiftUI

public struct SwipeGesture: ViewModifier {
    public enum Direction {
        case down, up, right, left, unknown
    }
    
    public var minimumDistance: CGFloat
    public var coordinateSpace: CoordinateSpace
    public var onChanged: (Direction, CGPoint) -> Void
    public var onEnded: (Direction, CGPoint) -> Void
    
    public init(minimumDistance: CGFloat,
                coordinateSpace: CoordinateSpace,
                onChanged: @escaping (Direction, CGPoint) -> Void,
                onEnded: @escaping (Direction, CGPoint) -> Void) {
        self.minimumDistance = minimumDistance
        self.coordinateSpace = coordinateSpace
        self.onChanged = onChanged
        self.onEnded = onEnded
    }
    
    public func body(content: Content) -> some View {
        content
            .gesture(DragGesture(minimumDistance: minimumDistance, coordinateSpace: coordinateSpace)
                .onChanged { value in
                    let direction = direction(y: value.translation.width, x: value.translation.height)
                    onChanged(direction, value.location)
                }
                .onEnded { value in
                    let direction = direction(y: value.translation.width, x: value.translation.height)
                    onEnded(direction, value.location)
                }
            )
    }
    
    private func direction(y: CGFloat, x: CGFloat) -> SwipeGesture.Direction {
        let direction = atan2(y, x)
        switch direction {
            case (-Double.pi / 4..<Double.pi / 4):
                return .down
            case (Double.pi / 4..<Double.pi*3 / 4):
                return .right
            case (Double.pi * 3/4...Double.pi), (-Double.pi..<(-Double.pi * 3/4)):
                return .up
            case (-Double.pi * 3/4..<(-Double.pi / 4)):
                return .left
            default:
                return .unknown
        }
    }
}

public extension View {
    func onSwipeGesture(minimumDistance: CGFloat = 10,
                        coordinateSpace: CoordinateSpace = .local,
                        onChanged: @escaping (SwipeGesture.Direction, CGPoint) -> Void = { _, _  in },
                        onEnded: @escaping (SwipeGesture.Direction, CGPoint) -> Void = { _, _ in }) -> some View {
        
        modifier(SwipeGesture(minimumDistance: minimumDistance,
                              coordinateSpace: coordinateSpace,
                              onChanged: onChanged,
                              onEnded: onEnded))
    }
}
