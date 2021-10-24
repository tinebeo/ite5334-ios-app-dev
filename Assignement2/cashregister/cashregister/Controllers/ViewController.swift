//
//  ViewController.swift
//  cashregister
//
//  Created by Christine Ebeo on 2021-10-22.
//

import UIKit

class ViewController: UIViewController ,
                      UITableViewDelegate,
                      UITableViewDataSource {
    
    // Products and quantity
    var products = [
        "Pants" : 20,
        "Shoes": 50,
        "Hats": 10,
        "Thirts": 10
        "Dresses":24
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

