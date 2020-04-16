//
//  Budget.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

class Budget: Object {
    
    @objc dynamic var identifier = NSUUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var periodicity = ""
    @objc dynamic var initialDate = Date()
    @objc dynamic var initialAmount: Float = 0.0
    @objc dynamic var amount: Float = 0.0
    @objc dynamic var rollover = false
    
    let transactions = List<Transaction>()
    
    convenience init(name: String, periodicity: String, initialAmount: Float) {
        self.init()
        self.name = name
        self.periodicity = periodicity
        self.initialAmount = initialAmount
        self.amount = initialAmount
        self.rollover = true
    }
    
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    override static func indexedProperties() -> [String] {
        return ["identifier"]
    }
}
