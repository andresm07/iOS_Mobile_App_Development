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
    
    let realmManager = RealmManager()
    
    public class func restartBudgetWithRollover(budget: Budget) {
        let hasRollover: Bool = budget.rollover
        let currentDate: Date = Date()
        var budgetEndingDate: Date
        if hasRollover {
            switch budget.periodicity {
            case "Weekly":
                budgetEndingDate = budget.initialDate + 7.days
                if budgetEndingDate == currentDate {
                    
                }
                
            case "Quarterly":
                budgetEndingDate = budget.initialDate + 15.days
                if budgetEndingDate == currentDate {
                    
                }
                
            case "Monthly":
                budgetEndingDate = budget.initialDate + 1.months
                if budgetEndingDate == currentDate {
                    
                }
                
            default:
                print("")
            }
        }
    }
    
    public class func restartBudgetWithoutRollover(budget: Budget) {
        let hasRollover: Bool = budget.rollover
        let currentDate: Date = Date()
        var budgetEndingDate: Date
        if !hasRollover {
            switch budget.periodicity {
            case "Weekly":
                budgetEndingDate = budget.initialDate + 7.days
                if budgetEndingDate == currentDate {
                    
                }
                
            case "Quarterly":
                budgetEndingDate = budget.initialDate + 15.days
                if budgetEndingDate == currentDate {
                    
                }
                
            case "Monthly":
                budgetEndingDate = budget.initialDate + 1.months
                if budgetEndingDate == currentDate {
                    
                }
                
            default:
                print("")
            }
        }
    }
}
