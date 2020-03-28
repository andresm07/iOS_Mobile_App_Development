//
//  Multiplication.swift
//  Quiz2
//
//  Created by admin on 3/28/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class Multiplication {
    var identifier = NSUUID().uuidString
    var mainMultiplication: String
    var multiplicationValue: Int
    
    init(mainMultiplication: String, multiplicationValue: Int) {
        self.mainMultiplication = mainMultiplication
        self.multiplicationValue = multiplicationValue
    }
}
