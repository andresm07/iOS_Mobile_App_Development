//
//  CategoryRealmStore.swift
//  CleanSwiftExample
//
//  Created by admin on 4/25/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryRealmStore: CategoryStoreProtocol {
    
    func insert(category: NativeCategory, completionHandler:() -> Void) {
        let category = RealmCategory(category: category)
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(category, update: .all)
            }
            completionHandler()
        } catch {
            print("")
            completionHandler()
        }
    }
    
    func fetchAll(completionHandler:(_ categories: [NativeCategory]) -> Void) {
        let realm = try? Realm()
        var categories = [NativeCategory]()
        guard let realmCategories = realm?.objects(RealmCategory.self) else {
            completionHandler(categories)
            return
        }
        for realmCategory in realmCategories {
            categories.append(realmCategory.toNativeCategory())
        }
        completionHandler(categories)
    }
    
    func fetch(id: String, completionHandler:(_ category: NativeCategory?) -> Void) {
        let realm = try? Realm()
        let searchPredicate = NSPredicate(format: "identifier = %@", id)
        let result = realm?.objects(RealmCategory.self).filter(searchPredicate)
        completionHandler(result?.first?.toNativeCategory())
    }
}
