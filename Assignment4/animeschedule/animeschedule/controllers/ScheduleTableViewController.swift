//
//  ScheduleTableViewController.swift
//  animeschedule
//
//  Created by Christine Ebeo on 2021-12-29.
//

import UIKit
import CoreData

class ScheduleTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        do{
            try CoreDataService.shared.fetchedResultController.performFetch()
            CoreDataService.shared.fetchedResultController.delegate = self
            
        } catch {
            print(error)
        }
        
    }
    
    // notify on change
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?){
        switch (type){
        case .insert:
            if let indexPath = newIndexPath {
                tableView.reloadData()
            }
            break
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        
        default: break
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = CoreDataService.shared.fetchedResultController.sections else {
            return 0
        }
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataService.shared.fetchedResultController.fetchedObjects!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
        
        var fave : FavouritesScheduleInfo = CoreDataService.shared.fetchedResultController.object(at: indexPath)
        
        cell.showTitle.text = fave.title;
        
        // set the image, use the data from api
        let url = URL(string: fave.image_url!)
        let queue = DispatchQueue.init(label: "1")
        queue.async {

            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.showImage.image = UIImage(data:data!)
                
            }
        }
        
        // get the day label
        // for now, refresh each time because this data needs to be dynamic since I dont know when api data refreshes
        JikanService.shared.getFavouriteSchedule(malId: fave.mal_id) {
            resultsFromApi in DispatchQueue.main.async {
                var scheduleResults = resultsFromApi
                
                if scheduleResults.monday.count != 0 {
                    cell.showDay.text = "MON"
                } else if scheduleResults.tuesday.count != 0 {
                    cell.showDay.text = "TUE"
                } else if scheduleResults.wednesday.count != 0 {
                    cell.showDay.text = "WED"
                } else if scheduleResults.thursday.count != 0 {
                    cell.showDay.text = "THU"
                } else if scheduleResults.friday.count != 0 {
                    cell.showDay.text = "FRI"
                } else if scheduleResults.saturday.count != 0 {
                    cell.showDay.text = "SAT"
                } else if scheduleResults.sunday.count != 0 {
                    cell.showDay.text = "SUN"
                } else {
                    cell.showDay.text = ""
                } 
                
            }
            
        }
        
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // custom row height
        return 100
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var fave : FavouritesScheduleInfo = CoreDataService.shared.fetchedResultController.object(at: indexPath)
            
            CoreDataService.shared.deleteFavourite(fsi: fave)


        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
