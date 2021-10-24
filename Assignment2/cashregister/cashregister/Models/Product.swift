//
//  Product.swift
//  cashregister
//
//  Created by Christine Ebeo on 2021-10-22.
//

import Foundation

class Product {
    var name : String
    var quantity : Int
    var price : Double
    
    init(n: String, q: Int, p: Double) {
        name = n
        quantity = q
        price = p
    }
}
