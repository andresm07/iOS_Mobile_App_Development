//
//  Product.swift
//  Tarea3
//
//  Created by admin on 3/22/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

class Product: Object {

    @objc dynamic var identifier = NSUUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var quantity = ""
    @objc dynamic var date = Date()
    @objc dynamic var imageName = ""
    
    convenience init(name: String, quantity: String, imageName: String) {
        self.init()
        self.name = name
        self.quantity = quantity
        self.imageName = imageName
    }
    
    override static func primaryKey() -> String? {
        return "identifier"
    }

    override static func indexedProperties() -> [String] {
        return ["identifier"]
    }
}



