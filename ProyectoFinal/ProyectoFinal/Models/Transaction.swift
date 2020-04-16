//
//  Transaction.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class Transaction {
    var detail: String
    var amount: Float
    var date = Date()
    
    init(detail: String, amount: Float) {
        self.detail = detail
        self.amount = amount
    }
}
