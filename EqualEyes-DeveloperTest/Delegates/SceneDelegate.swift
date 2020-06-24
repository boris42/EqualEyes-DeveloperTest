//
//  SceneDelegate.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 23/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let mainView = MainView()
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: mainView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

