//
//  SceneDelegate.swift
//  Example
//
//  Created by Mikhail Vospennikov on 14.02.2023.
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let newScene = scene as? UIWindowScene else {
            return
        }
        let newWindow = UIWindow(windowScene: newScene)
        newWindow.rootViewController = UIHostingController(rootView: ContentView())
        newWindow.makeKeyAndVisible()
        window = newWindow
    }
}
