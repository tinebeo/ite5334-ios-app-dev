//
//  History.swift
//  cashregister
//
//  Created by Christine Ebeo on 2021-10-22.
//

import Foundation

class History {
    
    var name : String;
    var quantity : Int;
    var totalPrice : Double;
    var purchaseDate : String;
    
    init(n: String, q: Int, t: Double) {
        name = n
        quantity = q
        totalPrice = t
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss a"
        purchaseDate = dateFormatter.string(from: Date())
        
        //purchaseDate = Date.now
    }
    
}
