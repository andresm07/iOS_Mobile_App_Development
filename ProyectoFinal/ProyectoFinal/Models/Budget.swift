//
//  Budget.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class Budget {
    var name: String
    var periodicity: Periodicity
    var initialDate = Date()
    var initialAmount: Float
    var rollover: Bool
    
    init(name: String, periodicity: Periodicity, initialAmount: Float) {
        self.name = name
        self.periodicity = periodicity
        self.initialAmount = initialAmount
        self.rollover = true
    }
    
    
    enum Periodicity {
        case weekly
        case quarterly
        case monthly
    }
}
