//
//  SceneDelegate.swift
//  MyCalc
//
//  Created by Ashish Dwivedi on 14/02/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainRouter: MainRouter?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()

        self.mainRouter = MainRouter(window: window)
        self.mainRouter?.showRootViewController()

        self.window = window
    }
}
