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
    
    let owners = LinkingObjects(fromType: User.self, property: "budgets")
    
    convenience init(name: String, periodicity: String, initialDate: Date, initialAmount: Float, rollover: Bool) {
        self.init()
        self.name = name
        self.periodicity = periodicity
        self.initialDate = initialDate
        self.initialAmount = initialAmount
        self.amount = initialAmount
        self.rollover = rollover
    }
    
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    override static func indexedProperties() -> [String] {
        return ["identifier"]
    }
}
