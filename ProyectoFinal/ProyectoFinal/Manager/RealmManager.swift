//
//  RealmManager.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    public func insertBudget(name: String, periodicity: String, initialAmount: Float) {
        let budget = Budget(name: name, periodicity: periodicity, initialAmount: initialAmount)
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(budget, update: .all)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    //Metodo sincrono
    public func getAllBudgets() -> Results<Budget>? {
        let realm = try? Realm()
        return realm?.objects(Budget.self)
    }
    
    //Metodo asincrono
    public func getAllBudgets(completionHandler:(_ budgets: Results<Budget>?) -> Void) {
        completionHandler(getAllBudgets())
    }
    
    public func addTransactionToBudget(transaction: Transaction, budget: Budget) {
        do {
            let realm = try Realm()
            try realm.write {
                budget.transactions.append(transaction)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    public func deleteBudget(budget: Budget) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(budget)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    public func deleteTransaction(transaction: Transaction) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(transaction)
            }
        } catch {
            print("Realm Error")
        }
    }
}

