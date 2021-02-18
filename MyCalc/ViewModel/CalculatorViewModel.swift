//
//  CalculatorViewModel.swift
//  MyCalc
//
//  Created by Ashish Dwivedi on 14/02/21.
//

import Foundation

class CalculatorViewModel: ViewModel {
    private var resultString: String = ""
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
    
    func set(value: String) {
        resultString = "\(resultString)\(value)"
    }
    
    func getResultText() -> String {
        resultString
    }
}

