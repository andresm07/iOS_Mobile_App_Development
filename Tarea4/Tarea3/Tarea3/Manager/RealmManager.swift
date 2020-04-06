//
//  RealmManager.swift
//  Tarea3
//
//  Created by admin on 3/28/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    public func insertProduct(name: String, quantity: String, imageName: String) {
        let product = Product(name: name, quantity: quantity, imageName: imageName)
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(product, update: .all)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    //Metodo sincrono
    public func getAllProducts() -> Results<Product>? {
        let realm = try? Realm()
        return realm?.objects(Product.self)
    }
    
    //Metodo asincrono
    public func getAllProducts(completionHandler:(_ products: Results<Product>?) -> Void) {
        completionHandler(getAllProducts())
    }
    
    public func addProduct(product: Product, products: Results<Product>) {
        do {
            let realm = try Realm()
            try realm.write {
                //
            }
        } catch {
            print("Realm Error")
        }
    }
    
    public func deleteProduct(product: Product) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(product)
            }
        } catch {
            print("Realm Error")
        }
    }
}
