//
//  ContentView.swift
//  Example
//
//  Created by Mikhail Vospennikov on 14.02.2023.
//

import SwiftUI
import Gestures

struct ContentView: View {
    @State var boxPosition = CGPoint(x: 200, y: 200)
    @State var fingerPosition: CGPoint?
    
    @State var touchLocation: String = "None"
    @State var swipeDirection: String = "None"
    
    var body: some View {
        ZStack {
            Color.white
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTouchGesture(count: 1) { gesture in
                    touchGestureAction(gesture)
                }
                .onSwipeGesture(minimumDistance: 15.0, coordinateSpace: .local) { direction, location in
                    swipeGestureChangedAction(direction, location: location)
                } onEnded: { direction, location in
                    swipeGestureEndAction(direction, location: location)
                }
            
            MovableRectangle
            Information
            if let fingerPosition {
                Finger(position: fingerPosition)
            }
        }
        .animation(.spring(), value: boxPosition)
    }
}

// MARK: - Gesture actions
private extension ContentView {
    func touchGestureAction(_ gesture: TouchGesture.Value) {
        touchLocation = gesture.location.roundedDescription
        boxPosition = gesture.location
        fingerPosition = gesture.location
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            fingerPosition = nil
        }
    }
    
    func swipeGestureChangedAction(_ direction: SwipeGesture.Direction, location: CGPoint) {
        swipeDirection = "\(direction): \(location.roundedDescription)"
        fingerPosition = location
    }
    
    func swipeGestureEndAction(_ direction: SwipeGesture.Direction, location: CGPoint) {
        swipeDirection = "\(direction): \(location.roundedDescription)"
        fingerPosition = nil
        switch direction {
            case .up: boxPosition.y -= 50
            case .down: boxPosition.y += 50
            case .left: boxPosition.x -= 50
            case .right: boxPosition.x += 50
            default: break
        }
    }
}

// MARK: - View builders
private extension ContentView {
    @ViewBuilder
    var MovableRectangle: some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .foregroundColor(.pink)
            .frame(width: 75, height: 75)
            .position(boxPosition)
    }
    
    @ViewBuilder
    var Information: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Touch location: " + touchLocation)
                Text("Swipe direction: " + swipeDirection)
                Spacer()
            }
            .lineLimit(1)
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    func Finger(position: CGPoint) -> some View {
        ZStack {
            Circle()
                .fill(Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0.75))
                .shadow(color: .black.opacity(0.40), radius: 8, x: 4, y: 4)
            Circle()
                .strokeBorder(Color(red: 0.65, green: 0.65, blue: 0.65), lineWidth: 1)
        }
        .frame(width: 42, height: 42)
        .position(position)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - Helpers
private extension CGPoint {
    var roundedDescription: String {
        "x: \(x.rounded()) y: \(y.rounded())"
    }
}
