//
//  ViewController.swift
//  calculator
//
//  Created by Christine Ebeo on 2021-09-21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblOutput: UILabel!
    @IBOutlet weak var historyOutput: UITextView!
    var calculator: Calculator = Calculator()
    var equalsIsPressed: Bool = false
    var advBtn: String = "Advance - With History"
    var stdBtn: String = "Standard - No History"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnClick(_ sender: UIButton) {
        
        switch sender.titleLabel!.text! {
            case "C":
                // clear
                lblOutput.text! = ""
                calculator.clearStatement()
                break
            case "=":
                equalsIsPressed = true
                
                // equals was pressed, but we hit an invalid operation previously, dont do anything
                if (lblOutput.text! == ErrorMessage.invalidOpt.rawValue) {
                    return
                }
            
                // validations passed
                do {
                    try calculator.calc()
                    lblOutput.text! = calculator.getStatement()
                } catch {
                    lblOutput.text! = ErrorMessage.invalidOpt.rawValue
                }
                
                // if on advanced, save history
                if (calculator.mode == CalculatorMode.advance) {
                    historyOutput.text = calculator.getHistory()
                }
                
                calculator.clearStatement()
                break
            default:
                // if operation was invalid previously or equals was pressed previously, clear the label
            if (lblOutput.text! == ErrorMessage.invalidOpt.rawValue
                    || equalsIsPressed) {
                    lblOutput.text! = ""
                    equalsIsPressed = false
                }
            
                // if push returns true, character was pushed successfully
                // otherwise, mark as invalid
                if (calculator.push(s: sender.titleLabel!.text!)) {
                    lblOutput.text! += sender.titleLabel!.text!

                } else {
                    lblOutput.text! = ErrorMessage.invalidOpt.rawValue
                    calculator.clearStatement()
                }
        }
    }
    
    @IBAction func historySettingBtnClick(_ sender: UIButton) {
        
        if (calculator.mode == CalculatorMode.standard) {
            sender.setTitle(advBtn, for: .normal)
            
            // when switched back to standard, clear the history output
            calculator.clearHistory()
            historyOutput.text = ""
            calculator.mode = CalculatorMode.advance
        } else {
            sender.setTitle(stdBtn, for: .normal)
            calculator.mode = CalculatorMode.standard
        }
        
        // hide/unhide the history area
        historyOutput.isHidden = !historyOutput.isHidden
        
    }
    
    
}

enum ErrorMessage: String {
    case invalidOpt = "Invalid Operation"
}

