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
    
    public func insertBudget(name: String, periodicity: String, initialDate: Date, initialAmount: Float, rollover: Bool) {
        let budget = Budget(name: name, periodicity: periodicity, initialDate: initialDate, initialAmount: initialAmount, rollover: rollover)
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(budget, update: .all)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    public func getAllBudgets() -> Results<Budget>? {
        let realm = try? Realm()
        return realm?.objects(Budget.self)
    }
    
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
    
    public func updateMainBudgetAmount(transaction: Transaction, budget: Budget) {
        do {
            let realm = try Realm()
            try realm.write {
                if transaction.type == "Deposit" {
                    budget.amount += transaction.amount
                } else if transaction.type == "Expense" {
                    budget.amount -= transaction.amount
                }
            }
        } catch {
            print("Realm Error")
        }
    }
    
    public func updateMainBudgetAmountDeletedTransaction(transaction: Transaction, budget: Budget) {
        do {
            let realm = try Realm()
            try realm.write {
                if transaction.type == "Deposit" {
                    budget.amount -= transaction.amount
                } else if transaction.type == "Expense" {
                    budget.amount += transaction.amount
                }
            }
        } catch {
            print("Realm Error")
        }
    }
    
    public func updateBudgetNameAndRollover(budget: Budget, name: String, rollover: Bool) {
        do {
            let realm = try Realm()
            try realm.write {
                budget.name = name
                budget.rollover = rollover
            }
        } catch {
            print("Realm Error")
        }
    }
    
    public func validateLogin(username: String, password: String) -> Bool{
        var found = false
        do {
            let realm = try Realm()
            let loginPredicate = NSPredicate(format: "username = %@ AND password = %@", username, password)
            let validUser = realm.objects(User.self).filter(loginPredicate)
            if validUser.count == 1 {
                found = true
            }
        } catch {
            print("Realm Error")
        }
        return found
    }
    
    public func getAllUsers() -> Results<User>? {
        let realm = try? Realm()
        return realm?.objects(User.self)
    }
    
    public func getAllUsers(completionHandler:(_ users: Results<User>?) -> Void) {
        completionHandler(getAllUsers())
    }
    
    public func insertUser(name: String, username: String, password: String) {
        let user = User(name: name, username: username, password: password)
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(user, update: .all)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    public func getUser(username: String) -> Results<User>? {
        let realm = try? Realm()
        let searchPredicate = NSPredicate(format: "username = %@", username)
        return realm?.objects(User.self).filter(searchPredicate)
    }
    
    public func getUser(username: String, completionHandler:(_ user: Results<User>?) -> Void) {
        completionHandler(getUser(username: username))
    }
    
    public func getBudget(identifier: String, name: String) -> Results<Budget>? {
        let realm = try? Realm()
        let searchPredicate = NSPredicate(format: "identifier = %@ AND name = %@", identifier, name)
        return realm?.objects(Budget.self).filter(searchPredicate)
    }
    
    public func getBudget(identifier: String, name: String, completionHandler:(_ budget: Results<Budget>?) -> Void) {
        completionHandler(getBudget(identifier: identifier, name: name))
    }
    
    public func deleteUserBudgets(user: User) {
        do {
            let realm = try Realm()
            try realm.write {
                for budget in user.budgets {
                    realm.delete(budget)
                }
            }
        } catch {
            print("Realm Error")
        }
    }
    
    public func getAllUserBudgets(user: User) -> Results<Budget>? {
        let realm = try? Realm()
        let searchPredicate = NSPredicate(format: "budget.owners.first.name = %@ AND budget.owners.first.username = %@", user.name, user.username)
        return realm?.objects(Budget.self).filter(searchPredicate)
    }
    
    public func getAllUserBudgets(user: User, completionHandler:(_ budgets: Results<Budget>?) -> Void) {
        completionHandler(getAllUserBudgets(user: user))
    }
    
    public func usernameExists(username: String) -> Results<User>? {
        let realm = try? Realm()
        let searchPredicate = NSPredicate(format: "username = %@", username)
        return realm?.objects(User.self).filter(searchPredicate)
    }
    
    public func usernameExists(username: String, completionHandler:(_ user: Results<User>?) -> Void) {
        completionHandler(usernameExists(username: username))
    }
    
    public func addBudgetToUser(user: User, name: String, periodicity: String, initialDate: Date, initialAmount: Float, rollover: Bool) {
        let budget = Budget(name: name, periodicity: periodicity, initialDate: initialDate, initialAmount: initialAmount, rollover: rollover)
        do {
            let realm = try Realm()
            try realm.write {
                user.budgets.append(budget)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    public func restartBudget(budget: Budget, name: String, periodicity: String, initialAmount: Float, rollover: Bool) {
        do {
            let realm = try Realm()
            try realm.write {
                budget.name = name
                budget.periodicity = periodicity
                budget.initialAmount = initialAmount
                budget.amount = initialAmount
                budget.initialDate = Date()
                budget.rollover = rollover
                let transaction = Transaction(detail: "Budget Restart", amount: initialAmount, type: "Rollover")
                budget.transactions.append(transaction)
            }
        } catch {
            print("Realm Error")
        }
    }
    
}

