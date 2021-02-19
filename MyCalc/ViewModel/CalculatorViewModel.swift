//
//  CalculatorViewModel.swift
//  MyCalc
//
//  Created by Ashish Dwivedi on 14/02/21.
//

import Foundation

class CalculatorViewModel: ViewModel {
    var viewManager: ViewManager?
    
    private var inputString: String = "" {
        didSet {
            self.viewManager?.reloadData()
        }
    }
    
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
        return self.inputString
    }
    
    func handleTap(on token: CalculatorToken) {
        switch token {
        case .equals:
            self.calculateAnswer()
        case _ where token.isAllClear:
            self.clear()
        default:
            self.set(for: token)
        }
    }
    
    private func set(for token: CalculatorToken) {
        if token.isOperand,
           token != .equals,
           token.isAllClear == false {
            if operationStack.count == 0, self.inputString.isEmpty {
                let zeroToken = CalculatorToken.zero
                self.operationStack.append(zeroToken)
                self.operationStack.append(token)
                self.inputString = ""
            } else if let topValue = self.operationStack.last {
                if topValue.isOperand {
                    _ = self.operationStack.popLast()
                    self.operationStack.append(token)
                    self.inputString = ""
                } else if topValue.isToken {
                    self.inputString += token.stringValue
                }
            } else {
                if let inputValue = Double(self.inputString) {
                    self.operationStack.append(.value(inputValue))
                    self.operationStack.append(token)
                    self.inputString = ""
                }
            }
        } else {
            self.inputString += token.stringValue
        }
    }
    
    private func clear() {
        self.inputString = ""
        self.operationStack.removeAll()
    }
    
    private func calculateAnswer() {
        let calcuations = {
            if let inputValue = Double(self.inputString) {
                self.operationStack.append(.value(inputValue))
                self.inputString = ""
            }
            
            guard let topValue = self.operationStack.last, topValue.isToken else {
                //Error Top value should not be a operand
                self.clear()
                return
            }
            
            guard self.operationStack.count >= 3 else {
                //Error statck should have atleast 3 token to calculate
                self.clear()
                return
            }
            
            var result = 0.0
            var stop: Bool = false
            var previousToken: CalculatorToken? = nil
            var currentToken: CalculatorToken? = nil
            var nextToken: CalculatorToken? = nil
            var iterator: Int = 3
            
            while stop == false {
                previousToken = self.operationStack[iterator - 3]
                currentToken = self.operationStack[iterator - 2]
                nextToken = self.operationStack[iterator - 1]
                
                switch currentToken {
                case .divide:
                    result = (previousToken?.doubleValue ?? 0.0) / (nextToken?.doubleValue ?? 0.0)
                case .multiply:
                    result = (previousToken?.doubleValue ?? 0.0) * (nextToken?.doubleValue ?? 0.0)
                case .plus:
                    result = (previousToken?.doubleValue ?? 0.0) + (nextToken?.doubleValue ?? 0.0)
                case .minus:
                    result = (previousToken?.doubleValue ?? 0.0) - (nextToken?.doubleValue ?? 0.0)
                default: break
                }
                
                for _ in 0..<3 {
                    self.operationStack.remove(at: 0)
                }
                
                self.operationStack.insert(.value(result), at: 0)
                
                iterator += 3
                if (iterator > self.operationStack.count) {
                    stop = true
                }
            }
            
            self.inputString = result.description
        }
        
        // Mock Api Call
        self.viewManager?.showLoader()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            calcuations()
            self?.viewManager?.hideLoader()
        }
    }
}

