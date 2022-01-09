//
//  SearchViewController.swift
//  animeschedule
//
//  Created by Christine Ebeo on 2021-12-29.
//

import UIKit

class SearchViewController: UIViewController,
                            UITableViewDelegate,
                            UITableViewDataSource {
    

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    lazy var searchResults = SearchResults(results: [SearchResultInfo]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
    }
    
    @IBAction func searchBtnOnClick(_ sender: Any) {
        // search button clicked, call API and search
        
        if let searchText = searchTextField.text {
            JikanService.shared.doSearch(input: searchText) {
                resultsFromApi in DispatchQueue.main.async {
                    self.searchResults = resultsFromApi
                    self.searchTableView.reloadData()
                }
                
            }
        }
        
        
        
    }
    
    // table view code
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        let item = searchResults.results[indexPath.row]
        cell.title.text = item.title
        
        // set airing image, green if true, red if false
        if (item.airing == false) {
            cell.airing.image = UIImage.init(named: "reddot")
        } else {
            cell.airing.image = UIImage.init(named: "greendot")
        }
        
        // set the image, use the data from api
        let url = URL(string: item.image_url)
        let queue = DispatchQueue.init(label: "1")
        queue.async {

            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                // should happend in Main Thread
                //self.imageView.image = UIImage(data:data!)
                cell.showImage.image = UIImage(data:data!)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
               heightForRowAt indexPath: IndexPath) -> CGFloat {
        // custom row height
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /*let item = searchResults.results[indexPath.row]
        guard let url = URL(string: item.url) else { return }
        UIApplication.shared.open(url)*/
        // item selected, prepare segue
        performSegue(withIdentifier: "resultDetails", sender: indexPath)
    }
    
    // segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! DetailsViewController
        dvc.resultInfo = searchResults.results[(sender as! IndexPath).row]
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
