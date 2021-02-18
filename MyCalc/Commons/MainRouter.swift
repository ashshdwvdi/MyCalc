//
//  MainRouter.swift
//  MyCalc
//
//  Created by Ashish Dwivedi on 18/02/21.
//

import UIKit

protocol MainRouterInterface {
    func show(viewController: UIViewController, sender: Any?)
}

class MainRouter {
    let window: UIWindow

    private var rootViewController: UIViewController? {

        guard let rootViewController = window.rootViewController else {
            assertionFailure("There is no rootViewController installed on the window")
            return nil
        }

        return rootViewController
    }

    init(window: UIWindow) {
        self.window = window
    }

    func showRootViewController() {
        self.showCalculatorViewController()
    }

    func showCalculatorViewController() {
        let rootViewController = Routes.create(withViewModel: CalculatorViewModel())
        self.window.rootViewController = rootViewController
    }
}


extension MainRouter: MainRouterInterface {

    func show(viewController: UIViewController, sender: Any?) {
        self.rootViewController?.show(viewController, sender: sender)
    }
}
