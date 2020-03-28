//
//  RealmManager.swift
//  Clase4
//
//  Created by admin on 3/28/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    public func insertCategory(name: String, imageName: String) {
        let category = Category(name: name, imageName: imageName)
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(category, update: .all)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    //Metodo sincrono
    public func getAllCategories() -> Results<Category>? {
        let realm = try? Realm()
        return realm?.objects(Category.self)
    }
    
    //Metodo asincrono
    public func getAllCategories(completionHandler:(_ categories: Results<Category>?) -> Void) {
        completionHandler(getAllCategories())
    }
    
    public func addNewsToCategory(news: News, category: Category) {
        do {
            let realm = try Realm()
            try realm.write {
                category.news.append(news)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    public func deleteNews(news: News) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(news)
            }
        } catch {
            print("Realm Error")
        }
    }
}

