//
//  RestockViewController.swift
//  cashregister
//
//  Created by Christine Ebeo on 2021-10-23.
//

import UIKit

class RestockViewController: UIViewController,
                             UITableViewDelegate,
                             UITableViewDataSource  {
    
    var store : Store?
    var productIdx : Int?
    @IBOutlet weak var restockTblView: UITableView!
    @IBOutlet weak var restockAmount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        restockTblView.delegate = self
        restockTblView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store!.getProductCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "restockCell", for: indexPath) as! CustomProductCell
        
        cell.productLbl.text = store!.getProduct(idx: indexPath.row).name
        cell.productQty.text = String(store!.getProduct(idx: indexPath.row).quantity)
        
        return cell
    }
    
    // functionality logic
    
    @IBAction func cancelClick(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
            
        } else {
            self.dismiss(animated: true, completion: nil)
        
        }
    }
    @IBAction func restockClick(_ sender: Any) {
        
        if (Int(restockAmount.text!) == nil
            || productIdx == nil) {
            let alert = UIAlertController(title: "Error!", message: "An invalid restock was made. Verify product and quantity.", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel,handler: nil)
           
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            store!.getProduct(idx: productIdx!).quantity = Int(restockAmount.text!)!
            
            restockTblView.reloadData()
            
            // reset selections
            restockAmount.text! = "Enter new quantity"
            productIdx = nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // product to updated selected
        productIdx = indexPath.row
        
        
    }

}
