//
//  Routes.swift
//  MyCalc
//
//  Created by Ashish Dwivedi on 18/02/21.
//

import UIKit

protocol RoutesFactory {
    static func create(withViewModel viewModel: ViewModel) -> UIViewController?
}

class Routes: RoutesFactory {
    
    static func create(withViewModel viewModel: ViewModel) -> UIViewController? {
        switch viewModel {
        case let vm as CalculatorViewModel:
            return CalculatorViewController(with: vm)
        default:
            assertionFailure("There is no viewController associated with the viewModel")
            return nil
        }
    }
}
