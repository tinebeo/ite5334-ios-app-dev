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
    
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var productQty: UILabel!
    @IBOutlet weak var productTotal: UILabel!
    @IBOutlet weak var productTblView: UITableView!
    
    // store holds the products
    var store : Store = Store()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.getProductCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! CustomProductCell
        
        cell.productLbl.text = store.getProduct(idx: indexPath.row).name
        cell.productQty.text = String(store.getProduct(idx: indexPath.row).quantity)
        cell.productPrice.text = String(store.getProduct(idx: indexPath.row).price)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // there's only one destination, directly set to that controller
        let s = segue.destination as? ManageViewController
        s?.store = store;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        productTblView.delegate = self
        productTblView.dataSource = self

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productTblView.reloadData()
    }
    
    // functionality logic below
    
    // extra functionality to clear inputs
    @IBAction func resetClick(_ sender: Any) {
        
        fieldReset()
    }
    
    func fieldReset(){
        productLbl.text! = "Product"
        productQty.text! = "Quantity"
        productTotal.text! = "Total"
        productTblView.reloadData()
        
        store.reset()
        
    }
    
    // update quantity label
    @IBAction func numClick(_ sender: UIButton) {
        // initial state
        if (productQty.text! == "Quantity") {
            productQty.text! = sender.titleLabel!.text!
        } else {
            productQty.text! += sender.titleLabel!.text!
        }
        
        // update store
        store.updateQuantity(q: Int(productQty.text!)!)
        
        // update total
        updateTotal()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // set the product name, switch when new cells were pressed
        productLbl.text! = store.getProduct(idx: indexPath.row).name
        
        // update store
        store.updateProduct(p: indexPath.row)
        
        // update total
        updateTotal()
    }
    
    
    
    func updateTotal() {
        
        let total = store.getTotal()

        // if total == 0, either product/quantity is missing
        // or user typed a 0 quantity
        if (total > 0) {
            productTotal.text! = String(total)
        }

    }

    @IBAction func buyClick(_ sender: UIButton) {

        // if sucessful purchase
        if (store.buy()) {
            // update the tableview
            productTblView.reloadData()
            fieldReset()
            
        } else {
            let alert = UIAlertController(title: "Error!", message: "An invalid purchase was made. Verify product and quantity.", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel,handler: nil)
           
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
        
    }
}

