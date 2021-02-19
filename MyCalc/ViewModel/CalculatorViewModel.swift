//
//  CalculatorViewModel.swift
//  MyCalc
//
//  Created by Ashish Dwivedi on 14/02/21.
//

import Foundation

class CalculatorViewModel: ViewModel {
    var viewManager: ViewManager?
    
    private var inputString: String = ""
    private var operationStack: [CalculatorToken] = []
    
    let calculatorRows: CalculatorRows = [
        [.answer],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .ac, .equals, .divide]
    ]
    
    func getRows(at indexPath: IndexPath) -> CalculatorToken {
        return self.calculatorRows[indexPath.section][indexPath.row]
    }
    
    func getResultText() -> String {
        return inputString
    }
    
    func handleTap(on token: CalculatorToken) {
        // if just token add to stack and result
        // check for operand
        // if first item is operand add 0 to stack and set result string
        // if top of stack is not a number then replace that with input operand
        // on equal to press calculate result with api call
    }
    
    private func set(for token: CalculatorToken) {
        // set token in stack
        // append token in result string
        // resultString = "\(resultString)\(value)"
    }
}

