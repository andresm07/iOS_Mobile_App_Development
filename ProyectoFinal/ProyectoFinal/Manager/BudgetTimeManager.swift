//
//  BudgetTimeManager.swift
//  ProyectoFinal
//
//  Created by admin on 4/19/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import SwiftDate

class BudgetTimeManager {
    
    public class func getRemainingDays(budget: Budget) -> String{
        var remainingDays = ""
        let budgetInitialDate: Date = budget.initialDate
        var budgetEndingDate: Date
        let currentDate: Date = Date()
        switch budget.periodicity {
        case "Weekly":
            budgetEndingDate = (budgetInitialDate + 7.days)
            if budgetEndingDate < currentDate {
                let hours = currentDate.getInterval(toDate: budgetEndingDate, component: .hour)
                if hours > 24 {
                    remainingDays = "\(String(budgetInitialDate.getInterval(toDate: budgetEndingDate, component: .day))) days"
                } else {
                    remainingDays = getTimerCountdown(budgetInitialDate: budgetInitialDate, budgetEndingDate: budgetEndingDate)
                }
            }
            
        case "Quarterly":
            budgetEndingDate = (budgetInitialDate + 15.days)
            if budgetEndingDate < currentDate {
                let hours = currentDate.getInterval(toDate: budgetEndingDate, component: .hour)
                if hours > 24 {
                    remainingDays = "\(String(budgetInitialDate.getInterval(toDate: budgetEndingDate, component: .day))) days"
                } else {
                    remainingDays = getTimerCountdown(budgetInitialDate: budgetInitialDate, budgetEndingDate: budgetEndingDate)
                }
            }
            
        case "Monthly":
            budgetEndingDate = (budgetInitialDate + 1.months)
            if budgetEndingDate < currentDate {
                let hours = currentDate.getInterval(toDate: budgetEndingDate, component: .hour)
                if hours > 24 {
                    remainingDays = "\(String(budgetInitialDate.getInterval(toDate: budgetEndingDate, component: .day))) days"
                } else {
                    remainingDays = getTimerCountdown(budgetInitialDate: budgetInitialDate, budgetEndingDate: budgetEndingDate)
                }
            }

        default:
            return ""
        }
        return remainingDays
    }
    
    private class func getTimerCountdown(budgetInitialDate: Date, budgetEndingDate: Date) -> String {
        var timeRemaining = ""
        return timeRemaining
    }
    
}
