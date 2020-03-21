//
//  Category.swift
//  Clase4
//
//  Created by admin on 3/20/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct Category {
    var identifier = NSUUID().uuidString
    var name: String
    var imageName: String
    var news: [News]
}
