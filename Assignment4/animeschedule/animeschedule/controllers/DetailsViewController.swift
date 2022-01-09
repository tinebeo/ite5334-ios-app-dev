//
//  DetailsViewController.swift
//  animeschedule
//
//  Created by Christine Ebeo on 2021-12-29.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //var photo_url : String = ""
    var resultInfo : SearchResultInfo?

    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showTitle: UITextView!
    @IBOutlet weak var airing: UIImageView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var synopsis: UITextView!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var viewWebsiteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showTitle.text = resultInfo?.title
        synopsis.text = resultInfo?.synopsis
        if (resultInfo!.airing == false) {
            airing.image = UIImage.init(named: "reddot")
        } else {
            airing.image = UIImage.init(named: "greendot")
        }
        
        score.text = String(format: "%.1f", resultInfo?.score as! CVarArg)
        
        // set the image, use the data from api
        let url = URL(string: resultInfo!.image_url)
        let queue = DispatchQueue.init(label: "1")
        queue.async {

            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                // should happend in Main Thread
                //self.imageView.image = UIImage(data:data!)
                self.showImage.image = UIImage(data:data!)
                
            }
        }
        
        // If this show is in favourites, update the icon to coloured one
        //CoreDataService.shared.fetchedResultController
        CoreDataService.shared.getFavourite(malId: Int32(resultInfo!.mal_id))
        // there's only either 0 or 1 one item here (i.e., unique mal_id)
        if let fave = CoreDataService.shared.searchFetchedResultController?.fetchedObjects {
            // this show is inside favourites
            if fave.count > 0 {
                favouriteBtn.setImage(UIImage.init(named: "favorite"), for: .normal)
                favouriteBtn.isEnabled = false
            }
            
        }
        
        
        
    }
    
    // View website button, navigates to show's website
    @IBAction func viewWebsiteBtnOnClick(_ sender: Any) {
        guard let url = URL(string: resultInfo!.url) else { return }
        UIApplication.shared.open(url)
    }
    
    // Favourite button, adds/removes from favourites
    @IBAction func favouriteBtnOnClick(_ sender: Any) {
        print("fave button clicked")
        
        // update fave button
        favouriteBtn.setImage(UIImage.init(named: "favorite"), for: .normal)
        favouriteBtn.isEnabled = false
        
        // save the details for this show
        CoreDataService.shared.addFavourite(malId: Int32(resultInfo!.mal_id), imageUrl: resultInfo!.image_url, title: resultInfo!.title)
        
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
