//
//  Product.swift
//  Tarea3
//
//  Created by admin on 3/22/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class Product {
    
    var identifier = NSUUID().uuidString
    var name: String
    var quantity: Int
    var date: String
    var imageName: String
    
    init(name: String, quantity: Int, date: String, imageName: String) {
        self.name = name
        self.quantity = quantity
        self.date = date
        self.imageName = imageName
    }
}
