//
//  Routes.swift
//  MyCalc
//
//  Created by Ashish Dwivedi on 18/02/21.
//

import UIKit

protocol RoutesFactory {
    //TODO: dont pass main router 
    static func create(withViewModel viewModel: ViewModel, and router: MainRouter) -> UIViewController?
}

class Routes: RoutesFactory {
    
    static func create(withViewModel viewModel: ViewModel, and router: MainRouter) -> UIViewController? {
        switch viewModel {
        case let vm as CalculatorViewModel:
            vm.router = router
            return CalculatorViewController(with: vm)
        default:
            assertionFailure("There is no viewController associated with the viewModel")
            return nil
        }
    }
}
