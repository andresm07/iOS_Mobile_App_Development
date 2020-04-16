//
//  Person.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    
    convenience init(name: String, username: String, password: String) {
        self.init()
        self.name = name
        self.username = username
        self.password = password
    }
}
