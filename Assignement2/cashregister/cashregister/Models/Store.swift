//
//  CashRegister.swift
//  cashregister
//
//  Created by Christine Ebeo on 2021-10-22.
//

import Foundation

class CashRegister {
    
    var products : [Product] = []
    
    //
    init(){
        products = [
            Product(n: "Pants", q: 20, p: 20.0),
            Product(n: "Shoes", q: 50, p: 10.0),
            Product(n: "Hats", q: 10, p: 5.0),
            Product(n: "Tshirts", q: 10, p: 8.0),
            Product(n: "Dresses", q: 24, p: 10.0)
        ]
    }
    
}
