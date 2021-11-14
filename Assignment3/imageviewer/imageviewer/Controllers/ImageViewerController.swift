//
//  ViewController.swift
//  imageviewer
//
//  Created by Christine Ebeo on 2021-11-12.
//

import UIKit

class ImageViewerController: UIViewController,
                   UIPickerViewDelegate,
                   UIPickerViewDataSource,
                   AddingNewImageProtocol{
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imagePicker: UIPickerView!
    
    var imageManager : ImageManager = ImageManager()
    
    // Picker details
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // column count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // get the image information
        /*let url = URL(string: imageManager.getImageList()[row].url)
        
        let data = try? Data(contentsOf: url!)
        self.imageView.image = UIImage(data:data!)
         */
         
        
        
        let url = URL(string: imageManager.getImageList()[row].url)
        print(imageManager.getImageList()[row].title)
        let queue = DispatchQueue.init(label: "1")
        queue.async {

            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                // should happend in Main Thread
                self.imageView.image = UIImage(data:data!)
            }
        }
        
        
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageManager.getImageList().count // row count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageManager.getImageList()[row].title // row data
    }
    
    // Handlers for new image tasks
    func controllerDidAdd(img: ImageInfo) {
        imageManager.addNewImage(i: img)
        imagePicker.reloadAllComponents()
        
    }
    
    func controllerDidCancel() {
        // nothing to do on cancel
    }
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nic = segue.destination as! NewImageController
        nic.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // initialize default image from local
        self.imageView.image = UIImage(named: "noimageavailable")
        
    }


}

