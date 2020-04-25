//
//  NativeCategory.swift
//  CleanSwiftExample
//
//  Created by admin on 4/25/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct NativeCategory {
    
    var identifier = NSUUID().uuidString
    var name: String
    var imageName: String
    var news: [NativeNews]
}
