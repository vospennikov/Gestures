//
//  ExampleApp.swift
//  Example
//
//  Created by Mikhail Vospennikov on 14.02.2023.
//

import SwiftUI

@main
enum ExampleApp {
    static func main() {
        if #available(iOS 14.0, *) {
            ExampleAppWindowGroup.main()
        } else {
            UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(SceneDelegate.self))
        }
    }
}
