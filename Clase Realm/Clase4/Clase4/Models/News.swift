//
//  News.swift
//  Clase4
//
//  Created by admin on 3/20/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

class News: Object {
    @objc dynamic var date = Date()
    @objc dynamic var title = ""
    @objc dynamic var descriptionNews = ""
    
    let categories = LinkingObjects(fromType: Category.self, property: "news")
    
    convenience init(title: String, descriptionNews: String) {
        self.init()
        self.title = title
        self.descriptionNews = descriptionNews
    }
}
