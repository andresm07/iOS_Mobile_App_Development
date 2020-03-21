//
//  Category.swift
//  Clase4
//
//  Created by admin on 3/20/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class Category {
    var identifier = NSUUID().uuidString
    var name: String
    var imageName: String
    var news: [News]
    
    init(name: String, imageName: String, news: [News]) {
        self.name = name
        self.imageName = imageName
        self.news = news
    }
}
