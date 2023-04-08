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
                    touchLocation = gesture.location.roundedDescription
                    boxPosition = gesture.location
                    fingerPosition = gesture.location
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        fingerPosition = nil
                    }
                }
                .onSwipeGesture(minimumDistance: 15.0, coordinateSpace: .local) { direction, location in
                    swipeDirection = "\(direction): \(location.roundedDescription)"
                    fingerPosition = location
                } onEnded: { direction, location in
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
            
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .foregroundColor(.pink)
                .frame(width: 75, height: 75)
                .position(boxPosition)
            
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
            
            if let fingerPosition {
                Circle()
                    .fill(Color(red: 0.7, green: 0.7, blue: 0.7))
                    .frame(width: 44, height: 44)
                    .shadow(color: .gray.opacity(0.7), radius: 8, x: 4, y: 4)
                    .position(fingerPosition)
            }
        }
        .animation(.spring(), value: boxPosition)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private extension CGPoint {
    var roundedDescription: String {
        "x: \(x.rounded()) y: \(y.rounded())"
    }
}
