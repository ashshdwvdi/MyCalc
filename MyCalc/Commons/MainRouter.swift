//
//  MainRouter.swift
//  MyCalc
//
//  Created by Ashish Dwivedi on 18/02/21.
//

import UIKit

protocol ViewManager {
    var loaderView: UIView? { get set }
    
    func show(viewController: UIViewController, sender: Any?)
    func showLoader(onView: UIView)
    func hideLoader()
}

class MainRouter {
    let window: UIWindow
    var loaderView: UIView?

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
        let rootViewController = Routes.create(withViewModel: CalculatorViewModel(), and: self)
        self.window.rootViewController = rootViewController
    }
}


extension MainRouter: ViewManager {

    func show(viewController: UIViewController, sender: Any?) {
        self.rootViewController?.show(viewController, sender: sender)
    }
    
    func showLoader(onView: UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8)
        
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        spinnerView.addSubview(activityIndicator)
        
        DispatchQueue.main.async {
            onView.addSubview(spinnerView)
        }
        
        self.loaderView = spinnerView
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.loaderView?.removeFromSuperview()
            self.loaderView = nil
        }
    }
}
