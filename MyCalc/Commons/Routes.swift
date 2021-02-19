//
//  Routes.swift
//  MyCalc
//
//  Created by Ashish Dwivedi on 18/02/21.
//

import UIKit

protocol RoutesFactory {
    static func create(withViewModel viewModel: ViewModel, and router: ViewManager) -> UIViewController?
}

class Routes: RoutesFactory {
    
    static func create(withViewModel viewModel: ViewModel, and viewManager: ViewManager) -> UIViewController? {
        switch viewModel {
        case let vm as CalculatorViewModel:
            vm.viewManager = viewManager
            return CalculatorViewController(with: vm)
        default:
            assertionFailure("There is no viewController associated with the viewModel")
            return nil
        }
    }
}
