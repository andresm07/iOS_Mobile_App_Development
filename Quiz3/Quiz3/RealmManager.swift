//
//  RealmManager.swift
//  Quiz3
//
//  Created by admin on 4/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    public func insertItem(tagNumber: Int, name: String, quantity: Int) {
        let item = Item(tagNumber: tagNumber, name: name, quantity: quantity)
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(item, update: .all)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    //Metodo sincrono
    public func getAllItems() -> Results<Item>? {
        let realm = try? Realm()
        return realm?.objects(Item.self)
    }
    
    //Metodo asincrono
    public func getAllItems(completionHandler:(_ items: Results<Item>?) -> Void) {
        completionHandler(getAllItems())
    }
}

