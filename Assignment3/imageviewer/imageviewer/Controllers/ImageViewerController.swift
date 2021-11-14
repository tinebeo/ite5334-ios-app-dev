//
//  ViewController.swift
//  imageviewer
//
//  Created by Christine Ebeo on 2021-11-12.
//

import UIKit

class ImageViewer: UIViewController,
                   UIPickerViewDelegate,
                   UIPickerViewDataSource,
                   AddingNewImageProtocol{
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imagePicker: UIPickerView!
    
    var imageManager : ImageManager = ImageManager()
    
    // Picker details
    /*func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //print(imageManager.getImageList().count)
        return 10//imageManager.getImageList().count
    
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return imageManager.getImageList()[row].title
    }*/
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //return 100
        return imageManager.getImageList().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return "iOS"
        
        return imageManager.getImageList()[row].title
    }
    
    // Handlers for new image tasks
    func controllerDidAdd(img: ImageInfo) {
        print(img.title)
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
    }


}

