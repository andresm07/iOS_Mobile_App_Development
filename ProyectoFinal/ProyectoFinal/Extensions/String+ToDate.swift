//
//  String+ToDate.swift
//  ProyectoFinal
//
//  Created by admin on 5/3/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension String {
    
    func stringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let newDate = dateFormatter.date(from: self)!
        return newDate
    }
}
