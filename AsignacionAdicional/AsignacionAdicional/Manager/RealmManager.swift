//
//  RealmManager.swift
//  AsignacionAdicional
//
//  Created by admin on 4/7/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    public func insertOwner(name: String, province: String, phoneNumber: String) {
        let owner = Owner(name: name, province: province, phoneNumber: phoneNumber)
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(owner, update: .all)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    //Metodo sincrono
    public func getAllOwners() -> Results<Owner>? {
        let realm = try? Realm()
        return realm?.objects(Owner.self)
    }
    
    //Metodo asincrono
    public func getAllOwners(completionHandler:(_ owners: Results<Owner>?) -> Void) {
        completionHandler(getAllOwners())
    }
    
    public func addAnimalToOwner(animal: Animal, owner: Owner) {
        do {
            let realm = try Realm()
            try realm.write {
                owner.animals.append(animal)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    public func deleteAnimal(animal: Animal) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(animal)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    public func findOwner(owner: Owner) -> Bool {
        var found = false
        do {
            let realm = try Realm()
            let lookedUpOwner = realm.objects(Owner.self).filter("Name = \(owner.name)")
            if owner == Owner(value: lookedUpOwner) {
                found = true
            }
        } catch {
            print("Realm Error")
        }
        return found
    }
}
