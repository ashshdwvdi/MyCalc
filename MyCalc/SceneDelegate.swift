//
//  SceneDelegate.swift
//  MyCalc
//
//  Created by Ashish Dwivedi on 14/02/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.loadInitialViewController(in: windowScene)
    }
}


fileprivate extension SceneDelegate {
    
    func loadInitialViewController(in windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = CalculatorViewController(with: CalculatorViewModel())
        self.window = window
        window.makeKeyAndVisible()
    }
}
