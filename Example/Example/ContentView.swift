//
//  ContentView.swift
//  Example
//
//  Created by Mikhail Vospennikov on 14.02.2023.
//

import SwiftUI
import Gestures

struct ContentView: View {
    @State var touchLocation: String = "None"
    @State var swipeDirection: String = "None"
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .onTouchGesture(count: 1) { gesture in
                    touchLocation = "x: \(gesture.location.x.rounded()), y: \(gesture.location.y.rounded())"
                }
                .onSwipeGesture(minimumDistance: 15.0, coordinateSpace: .local) { gesture in
                    swipeDirection = "\(gesture)"
                } onEnded: { gesture in
                    swipeDirection = "\(gesture)"
                }
            
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
