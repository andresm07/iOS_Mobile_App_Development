//
//  Animal.swift
//  AsignacionAdicional
//
//  Created by admin on 3/28/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

class Animal: Object {
    
    @objc dynamic var identifier = NSUUID().uuidString
    @objc dynamic var animalType = ""
    @objc dynamic var imageName = ""
    @objc dynamic var name = ""
    @objc dynamic var province = ""
    @objc dynamic var phoneNumber = ""
    
    //let owners = LinkingObjects(fromType: Owner.self, property: "animals")
    
    convenience init(animalType: String, imageName: String, name: String,
                     province: String, phoneNumber: String) {
        self.init()
        self.animalType = animalType
        self.imageName = imageName
        self.name = name
        self.province = province
        self.phoneNumber = phoneNumber
    }
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    override static func indexedProperties() -> [String] {
        return ["identifier"]
    }
}
