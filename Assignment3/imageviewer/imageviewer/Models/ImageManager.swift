//
//  ImageManager.swift
//  imageviewer
//
//  Created by Christine Ebeo on 2021-11-12.
//

import Foundation

class ImageManager {
    
    private var imageList = [ImageInfo]()
    
    func addNewImage(i: ImageInfo) {
        imageList.append(i)
    }
    
    func getImageList() -> [ImageInfo] {
        return imageList
    }
}
