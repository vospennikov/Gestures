//
//  TouchGesture.swift
//  Gestures
//
//  Created by Mikhail Vospennikov on 26.12.2022.
//

import SwiftUI

public struct TouchGesture: ViewModifier {
    public var count: Int
    public var coordinateSpace: CoordinateSpace
    public var onEnded: (Value) -> Void
    @State private var touchLocation: CGPoint = .zero
    
    public struct Value: Equatable {
        public var location: CGPoint
        public static func == (a: TouchGesture.Value, b: TouchGesture.Value) -> Bool {
            a.location == b.location
        }
    }
    
    public func body(content: Content) -> some View {
        content.gesture(tapGesture)
    }
    
    private var tapGesture: some Gesture {
        if #available(iOS 16.0, *) {
            return SpatialTapGesture(count: count)
                .onEnded { gesture in
                    touchLocation = gesture.location
                }
        } else {
            return SequenceGesture(TapGesture(count: count),
                                   DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onEnded { value in
                    guard ((value.startLocation.x - 1)...(value.startLocation.x + 1)).contains(value.location.x),
                          ((value.startLocation.y - 1)...(value.startLocation.y + 1)).contains(value.location.y) else {
                        return
                    }
                    onEnded(.init(location: value.location))
                }
            )
        }
    }
}

public extension View {
    func onTouchGesture(count: Int,
                        coordinateSpace: CoordinateSpace = .local,
                        onEnded: @escaping (TouchGesture.Value) -> Void = { _ in }) -> some View {
        modifier(TouchGesture(count: count, coordinateSpace: coordinateSpace, onEnded: onEnded))
    }
}
