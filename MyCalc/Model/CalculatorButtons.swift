//
//  CalculatorButtons.swift
//  MyCalc
//
//  Created by Ashish Dwivedi on 14/02/21.
//

import Foundation

typealias CalculatorButtons = [CalculatorToken]

typealias CalculatorRows = [CalculatorButtons]

enum CalculatorToken {
    case answer
    case ac, divide
    case seven, eight, nine, multiply
    case four, five, six, minus
    case one, two, three, plus
    case zero, equals
    case value(Double)
}

extension CalculatorToken: Equatable {
    
    var stringValue: String {
        switch self {
        case .answer: return ""
        case .ac: return "AC"
        case .divide: return "÷"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .multiply: return "×"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .minus: return "-"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .plus: return "+"
        case .zero: return "0"
        case .equals: return "="
        case .value(let customValue): return customValue.description
        }
    }
    
    var doubleValue: Double {
        switch self {
        case .seven: return 7
        case .eight: return 8
        case .nine: return 9
        case .four: return 4
        case .five: return 5
        case .six: return 6
        case .one: return 1
        case .two: return 2
        case .three: return 3
        case .zero: return 0
        case .value(let customValue): return customValue
        default: return 0
        }
    }
    
    var isOperand: Bool {
        switch self {
        case .divide, .multiply, .minus, .plus, .equals: return true
        default: return false
        }
    }
    
    var isToken: Bool {
        return self.isOperand == false
    }
    
    var isAllClear: Bool {
        return self == .ac
    }
    
    var isAnswer: Bool {
        return self == .answer
    }
}
