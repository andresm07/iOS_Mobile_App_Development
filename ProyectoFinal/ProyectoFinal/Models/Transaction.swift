//
//  Transaction.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

class Transaction: Object {
    
    @objc dynamic var detail = ""
    @objc dynamic var amount: Float = 0.0
    @objc dynamic var date = Date()
    
    let budgets = LinkingObjects(fromType: Budget.self, property: "transactions")
    
    convenience init(detail: String, amount: Float) {
        self.init()
        self.detail = detail
        self.amount = amount
    }
}
