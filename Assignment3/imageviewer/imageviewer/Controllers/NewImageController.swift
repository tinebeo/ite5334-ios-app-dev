//
//  NewImageController.swift
//  imageviewer
//
//  Created by Christine Ebeo on 2021-11-12.
//

import UIKit

protocol AddingNewImageProtocol {
    func controllerDidAdd(img: ImageInfo)
    func controllerDidCancel()
}

class NewImageController: UIViewController {

    public var delegate: AddingNewImageProtocol?
    
    @IBOutlet weak var imageTitle: UITextField!
    @IBOutlet weak var imageUrl: UITextField!
    @IBOutlet weak var alertTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // hide the back button
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    // Add
    @IBAction func addBtnClick(_ sender: Any) {
        
        if let title = imageTitle.text {
            if let url = imageUrl.text {
                if !title.isEmpty && !url.isEmpty {
                    if (verifyUrl(urlString: url)) {
                        let newImage = ImageInfo(t: title, u: url)
                            
                        delegate?.controllerDidAdd(img: newImage)
                        dismiss(animated: true, completion: nil)
                    } else {
                        
                        alertTxt.text = "Invalid URL"
                    }
                    
                } else {
                    
                    alertTxt.text = "Missing input"
                }
            }
        }
    }
    
    // Cancel
    @IBAction func cancelBtnClick(_ sender: Any) {
        delegate?.controllerDidCancel()
        dismiss(animated: true, completion: nil)
    }
    
    
    // helper to validate url
    // source: https://stackoverflow.com/questions/28079123/how-to-check-validity-of-url-in-swift
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }

}
