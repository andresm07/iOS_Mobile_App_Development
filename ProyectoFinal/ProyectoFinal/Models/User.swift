//
//  Person.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object, NSCoding {
    
    @objc dynamic var identifier = NSUUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    
    let budgets = List<Budget>()
    
    convenience init(name: String, username: String, password: String) {
        self.init()
        self.name = name
        self.username = username
        self.password = password
    }
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    override static func indexedProperties() -> [String] {
        return ["identifier"]
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let identifier = aDecoder.decodeObject(forKey: "identifier") as! String
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let username = aDecoder.decodeObject(forKey: "username") as! String
        let password = aDecoder.decodeObject(forKey: "password") as! String
        self.init(name: name, username: username, password: password)
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.identifier, forKey: "identifier")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.username, forKey: "username")
        aCoder.encode(self.password, forKey: "password")
    }
}
