//
//  BudgetRolloverManager.swift
//  ProyectoFinal
//
//  Created by admin on 4/24/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import SwiftDate

class BudgetRolloverManager {
    
    public class func restartBudgetWithRollover(budget: Budget) {
        let realmManager = RealmManager()
        let hasRollover: Bool = budget.rollover
        let currentDate: Date = Date()
        var budgetEndingDate: Date
        if hasRollover {
            switch budget.periodicity {
            case "Weekly":
                budgetEndingDate = (budget.initialDate + 7.days)
                if budgetEndingDate == currentDate {
                    realmManager.restartBudget(budget: budget, name: budget.name, periodicity: budget.periodicity, initialAmount: budget.amount, rollover: budget.rollover)
                }
                
            case "Quarterly":
                budgetEndingDate = (budget.initialDate + 15.days)
                if budgetEndingDate == currentDate {
                    realmManager.restartBudget(budget: budget, name: budget.name, periodicity: budget.periodicity, initialAmount: budget.amount, rollover: budget.rollover)
                }
                
            case "Monthly":
                budgetEndingDate = (budget.initialDate + 1.months)
                if budgetEndingDate == currentDate {
                    realmManager.restartBudget(budget: budget, name: budget.name, periodicity: budget.periodicity, initialAmount: budget.amount, rollover: budget.rollover)
                }
                
            default:
                print("")
            }
        }
    }
    
    public class func restartBudgetWithoutRollover(budget: Budget) {
        let realmManager = RealmManager()
        let hasRollover: Bool = budget.rollover
        let currentDate: Date = Date()
        var budgetEndingDate: Date
        if !hasRollover {
            switch budget.periodicity {
            case "Weekly":
                budgetEndingDate = (budget.initialDate + 7.days)
                if budgetEndingDate == currentDate {
                    realmManager.restartBudget(budget: budget, name: budget.name, periodicity: budget.periodicity, initialAmount: 0.0, rollover: budget.rollover)
                }
                
            case "Quarterly":
                budgetEndingDate = (budget.initialDate + 15.days)
                if budgetEndingDate == currentDate {
                    realmManager.restartBudget(budget: budget, name: budget.name, periodicity: budget.periodicity, initialAmount: 0.0, rollover: budget.rollover)
                }
                
            case "Monthly":
                budgetEndingDate = (budget.initialDate + 1.months)
                if budgetEndingDate == currentDate {
                    realmManager.restartBudget(budget: budget, name: budget.name, periodicity: budget.periodicity, initialAmount: 0.0, rollover: budget.rollover)
                }
                
            default:
                print("")
            }
        }
    }
}
