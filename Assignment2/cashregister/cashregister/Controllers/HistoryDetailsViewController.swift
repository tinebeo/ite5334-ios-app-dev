//
//  HistoryDetailsViewController.swift
//  cashregister
//
//  Created by Christine Ebeo on 2021-10-23.
//

import UIKit

class HistoryDetailsViewController: UIViewController {

    var history : History?
    
    @IBOutlet weak var histoyLabel: UILabel!
    @IBOutlet weak var historyQuantity: UILabel!
    @IBOutlet weak var historypurchaseDate: UILabel!
    @IBOutlet weak var historyTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // update title
        self.title = history!.name
        
        // update historyDetails
        histoyLabel.text! = "\(history!.name)\n"
        historyQuantity.text! = "\(String(history!.quantity))\n"
        historypurchaseDate.text! = "\(history!.purchaseDate)\n"
        historyTotal.text! = "Total amount: \(String(history!.totalPrice))"

    }

}
