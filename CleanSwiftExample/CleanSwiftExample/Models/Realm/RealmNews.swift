//
//  RealmNews.swift
//  CleanSwiftExample
//
//  Created by admin on 4/25/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmNews: Object {
    
    @objc dynamic var date = Date()
    @objc dynamic var title = ""
    @objc dynamic var descriptionNews = ""
    
    let categories = LinkingObjects(fromType: RealmCategory.self, property: "news")
    
    convenience init(news: NativeNews) {
        self.init()
        self.date = news.date
        self.title = news.title
        self.descriptionNews = news.descriptionNews
    }
    
    func toNativeNews() -> NativeNews {
        return NativeNews(date: self.date, title: self.title, descriptionNews: self.descriptionNews)
    }
}
