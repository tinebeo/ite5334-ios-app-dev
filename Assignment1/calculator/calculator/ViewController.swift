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
    
    // use these for enabling/disabling buttons
    // cant find a way to update buttons using only one variable
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnMultiply: UIButton!
    @IBOutlet weak var btnDivide: UIButton!
    @IBOutlet weak var btnEquals: UIButton!
    
    lazy var numButtons = [btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9, btn0, btnPlus, btnMultiply, btnDivide, btnEquals]
    lazy var optButtons = [btnPlus, btnMinus, btnMultiply, btnDivide, btnEquals]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        
        switch sender.titleLabel!.text! {
            case "C":
                // clear the equation box
                lblOutput.text! = ""
                // activate the numbers and inactivate the operator buttons
                toogleButtons(numIsEnabled: true, optIsEnabled: false)
                // reset the calculator statement list
                calculator.clearStatement()
                break
            case "=":
                // calculate
                calculator.calc()
                // show the resulting statement
                lblOutput.text! = calculator.getStatement()
                
                // if on advanced, save history
                if (calculator.mode == CalculatorMode.advance) {
                    historyOutput.text = calculator.getHistory()
                }
            
                // activate the numbers and inactivate the operator buttons
                toogleButtons(numIsEnabled: true, optIsEnabled: false)
                // reset the calculator statement list
                calculator.clearStatement()
                break
            default:
                // numbers or operators were pressed
                // add the current pressed button to the statement list
                calculator.push(s: sender.titleLabel!.text!)
                // activate/inactivate buttons depending on what was pressed
                toogleButtons(numIsEnabled: !btn1.isEnabled, optIsEnabled: !btnPlus.isEnabled)
                lblOutput.text! = calculator.getStatement()
        }
    }
    
    @IBAction func historySettingBtnClick(_ sender: UIButton) {
        
        if (calculator.mode == CalculatorMode.standard) {
            sender.setTitle("Advance - With History", for: .normal)
            
            // when switched back to standard, clear the history output
            calculator.clearHistory()
            historyOutput.text = ""
            calculator.mode = CalculatorMode.advance
        } else {
            sender.setTitle("Standard - No History", for: .normal)
            calculator.mode = CalculatorMode.standard
        }
        
        // hide/unhide the history area
        historyOutput.isHidden = !historyOutput.isHidden
        
    }
    
    // enable disables buttons
    func toogleButtons(numIsEnabled: Bool, optIsEnabled: Bool) {
        for button in numButtons {
            button!.isEnabled = numIsEnabled
            // updates the button colors
            updateBtnColor(button: button!, color: UIColor.systemOrange)
            
        }
        
        for button in optButtons {
            button!.isEnabled = optIsEnabled
            updateBtnColor(button: button!, color: UIColor.systemIndigo)
        }
    }
    
    // gray/ungray the buttons
    func updateBtnColor(button : UIButton, color: UIColor) {
        if (!button.isEnabled) {
            button.backgroundColor = UIColor.darkGray
        } else {
            button.backgroundColor = color
        }
    }
}
