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
    var quantity: String
    var date = Date()
    var imageName: String
    
    init(name: String, quantity: String, imageName: String) {
        self.name = name
        self.quantity = quantity
        self.imageName = imageName
    }
}
