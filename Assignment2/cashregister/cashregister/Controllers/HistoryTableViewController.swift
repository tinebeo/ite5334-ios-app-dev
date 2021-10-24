//
//  HistoryTableViewController.swift
//  cashregister
//
//  Created by Christine Ebeo on 2021-10-22.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    // main View controller assigns this value
    var store : Store?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store!.getHistoryCount()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! CustomProductCell
        
        cell.productLbl.text = store?.getHistory(idx: indexPath.row).name
        cell.productQty.text = String(store!.getHistory(idx: indexPath.row).quantity)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // item selected, prepare segue
        performSegue(withIdentifier: "historyDetails", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // there's only one destination, directly set to that controller
        let s = segue.destination as? HistoryDetailsViewController
        s?.history = (store?.getHistory(idx: (sender as! IndexPath).row))!
        
    }
    
}
