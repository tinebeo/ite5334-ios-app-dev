//
//  CashRegister.swift
//  cashregister
//
//  Created by Christine Ebeo on 2021-10-22.
//

import Foundation

class Store {
    
    var products : [Product] = []
    var history : [History] = []
    
    // current selected Product and quantity
    var product : Product?
    var quantity : Int?
    
    // initialize store with the following products
    init(){
        products = [
            Product(n: "Pants", q: 20, p: 20.0),
            Product(n: "Shoes", q: 50, p: 10.0),
            Product(n: "Hats", q: 10, p: 5.0),
            Product(n: "Tshirts", q: 10, p: 8.0),
            Product(n: "Dresses", q: 24, p: 10.0)
        ]
    }
    
    func getProductCount() -> Int {
        return products.count
    }
    
    func getHistoryCount() -> Int {
        return history.count
    }
    
    // given an index, return the product
    func getProduct(idx : Int) -> Product {
        return products[idx]
    }
    
    func getHistory(idx : Int) -> History {
        return history[idx]
    }
    
    func updateQuantity(q : Int) {
        quantity = q
    }
    
    // product to purchase
    func updateProduct(p : Int) {
        product = getProduct(idx: p)
    }
    
    func getTotal() -> Double {
        
        var total = 0.0
        
        if (product != nil && quantity != nil) {
            total = product!.price * Double(quantity!)
        }
        
        return total
    }
    
    func buy() -> Bool {
        
        var purchaseStatus = false;
        
        if (product != nil && quantity != nil
            && product!.quantity >= quantity!) {
            
            purchaseStatus = true
            
            // add purchase to history
            history.append(History(
                n: product!.name,
                q: quantity!,
                t: product!.price * Double(quantity!)
            ))
            
            // update product quantity
            product!.quantity -= quantity!
            
        }
        
        return purchaseStatus
    
    }
    
    func reset() {
        product = nil
        quantity = nil
    }
}
