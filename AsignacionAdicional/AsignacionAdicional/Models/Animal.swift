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
    
    @objc dynamic var animalType = ""
    @objc dynamic var imageName = ""
    
    let owners = LinkingObjects(fromType: Owner.self, property: "animals")
    
    convenience init(animalType: String, imageName: String) {
        self.init()
        self.animalType = animalType
        self.imageName = imageName
    }
}
