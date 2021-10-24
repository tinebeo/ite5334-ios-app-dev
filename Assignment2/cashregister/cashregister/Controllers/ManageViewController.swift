//
//  ManageViewController.swift
//  cashregister
//
//  Created by Christine Ebeo on 2021-10-22.
//

import UIKit

class ManageViewController: UIViewController {

    // main View controller assigns this value
    var store : Store?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if (segue.identifier == "history") {
            let s = (segue.destination as? HistoryTableViewController)!
            s.store = store;
            
        } else  {
            let s = (segue.destination as? RestockViewController)!
            s.store = store;
        }
        
    }

}
