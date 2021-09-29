//
//  Calculator.swift
//  calculator
//
//  Created by Christine Ebeo on 2021-09-21.
//

import Foundation
import UIKit

class Calculator {
    
    var statement = [String]()
    var history = [String]()
    // standard (default) or advance
    var mode = CalculatorMode.standard
    
    // Adds items to statement to use for calculation later
    // Excludes "=" and output. These are handled in calc
    func push(s: String) -> Bool {
        // validate the input
        // error on the following:
        // - list is empty and operand was used
        // - consecutive numbers/operands were used
        if ((statement.isEmpty && !s.isInt)
            || (!statement.isEmpty && statement.last!.isInt && s.isInt)
            || (!statement.isEmpty && !statement.last!.isInt && !s.isInt)) {
            return false
        }
        
        statement.append(s)
        
        return true
    }
    
    // Perform calculation
    func calc() throws {
        
        var result = 0
        var prev: String? = nil
        
        for ch in statement {
            // if character is a number check if calculation is needed
            // else move forward
            if (ch.isInt) {
                // if prev not nil, apply the operand
                if (prev != nil) {
                    result = try applyOpt(x: result, y: Int(ch)!, opt: prev!)
                } else {
                    result = Int(ch)!
                }
                
            }
            
            prev = ch
            
        }
        // complete the statement, add =result
        statement.append("=" + String(result))
        
        // save history if on advance mode
        if (mode == CalculatorMode.advance) {
            saveHistory()
        }

    }
    
    // Helper to do the calculation
    func applyOpt(x: Int, y: Int, opt: String) throws -> Int {
        
        var result: Int = 0
        switch opt {
            case "+":
                result = x + y
                break
            case "-":
                result = x - y
                break
            case "*":
                result = x * y
                break
            case "/":
                // output 0 if division by 0
                if (y == 0) {
                    result = 0
                } else {
                    result = x / y
                }
                break
            default:
                break
                // nothing to do
        }
        
        return result
    }
    
    // Clean/reset the statement list
    func clearStatement() {
        statement = [String]()
    }
    
    func getStatement() -> String {
        return statement.joined(separator: "")
    }
    
    // Get calculation history
    func getHistory() -> String {
        return history.joined(separator: "\n")
    }
    
    func saveHistory() {
        // add current statement to history
        
        history.append(statement.joined(separator: ""))
    }
    
    func clearHistory() {
        history = [String]()
    }
    
}

// source : https://stackoverflow.com/questions/38159397/how-to-check-if-a-string-is-an-int-in-swift
extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

enum CalculatorMode {
    case standard
    case advance
}
