//
//  RealmCategory.swift
//  CleanSwiftExample
//
//  Created by admin on 4/25/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCategory: Object {
    
    @objc dynamic var identifier = NSUUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var imageName = ""
    let news = List<RealmNews>()
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    override static func indexedProperties() -> [String] {
        return ["identifier"]
    }
    
    convenience init(category: NativeCategory) {
        self.init()
        self.identifier = category.identifier
        self.name = category.name
        self.imageName = category.imageName
        for newsObject in category.news {
            self.news.append(RealmNews(news: newsObject))
        }
    }
    
    func toNativeCategory() -> NativeCategory {
        return NativeCategory(identifier: self.identifier, name: self.name, imageName: self.imageName, news: self.news.map({$0.toNativeNews()}))
    }
}

