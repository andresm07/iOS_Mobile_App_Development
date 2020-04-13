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
    public func insertAnimal(animalType: String, imageName: String, name: String, province: String, phoneNumber: String) {
        let animal = Animal(animalType: animalType, imageName: imageName, name: name, province: province, phoneNumber: phoneNumber)
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(animal, update: .all)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    //Metodo sincrono
    public func getAllAnimals() -> Results<Animal>? {
        let realm = try? Realm()
        return realm?.objects(Animal.self)
    }
    
    //Metodo asincrono
    public func getAllAnimals(completionHandler:(_ animals: Results<Animal>?) -> Void) {
        completionHandler(getAllAnimals())
    }
    
//    public func addAnimalToOwner(animal: Animal, owner: Owner) {
//        do {
//            let realm = try Realm()
//            try realm.write {
//                owner.animals.append(animal)
//            }
//        } catch {
//            print("Realm Error")
//        }
//    }
    
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
    
//    public func findOwner(owner: Owner) -> Bool {
//        var found = false
//        do {
//            let realm = try Realm()
//            let lookedUpOwner = realm.objects(Owner.self).filter("name = %@", owner.name)
//            if !lookedUpOwner.isEmpty {
//                found = true
//            }
//        } catch {
//            print("Realm Error")
//        }
//        return found
//    }
}
