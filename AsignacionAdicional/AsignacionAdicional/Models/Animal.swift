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
    
    @objc dynamic var date = Date()
    @objc dynamic var title = ""
    @objc dynamic var descriptionNews = ""
    
    let owners = LinkingObjects(fromType: Owner.self, property: "animals")
    
    convenience init(title: String, descriptionNews: String) {
        self.init()
        self.title = title
        self.descriptionNews = descriptionNews
    }
}
