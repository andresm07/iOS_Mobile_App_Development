//
//  CarModel.swift
//  TableViewWithCustomHeaders
//
//  Created by admin on 4/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct CarModel {
    
    enum EngineType {
        case gasoline
        case diesel
        case electric
    }
    var name: String
    var year: Int
    var engine: EngineType
    
}
