//
//  VisualizeBudgetTableViewController.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import SwiftDate

class VisualizeBudgetTableViewController: UITableViewController {
    
    
    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetAmountLabel: UILabel!
    @IBOutlet weak var daysRemainingLabel: UILabel!
    
    var budget: Budget?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let budget = self.budget {
            self.budgetNameLabel.text = budget.name
            self.budgetAmountLabel.text = String(budget.amount)
            self.daysRemainingLabel.text = getRemainingDays()
        }
        
    }
    
    private func getRemainingDays() -> String{
        var remainingDays = ""
        let budgetInitialDate: Date = self.budget!.initialDate
        var budgetEndingDate: Date
        switch self.budget?.periodicity {
        case "Weekly":
            budgetEndingDate = (budgetInitialDate + 7.days)
            let hours = budgetInitialDate.getInterval(toDate: budgetEndingDate, component: .hour)
            if hours > 24 {
                remainingDays = "\(String(budgetInitialDate.getInterval(toDate: budgetEndingDate, component: .day))) days"
            } else {
                remainingDays = getTimerCountdown(budgetInitialDate: budgetInitialDate, budgetEndingDate: budgetEndingDate)
            }
            
        case "Quarterly":
            budgetEndingDate = (budgetInitialDate + 15.days)
            let hours = budgetInitialDate.getInterval(toDate: budgetEndingDate, component: .hour)
            if hours > 24 {
                remainingDays = "\(String(budgetInitialDate.getInterval(toDate: budgetEndingDate, component: .day))) days"
            } else {
                remainingDays = getTimerCountdown(budgetInitialDate: budgetInitialDate, budgetEndingDate: budgetEndingDate)
            }
            
        case "Monthly":
            budgetEndingDate = (budgetInitialDate + 1.months)
            let hours = budgetInitialDate.getInterval(toDate: budgetEndingDate, component: .hour)
            if hours > 24 {
                remainingDays = "\(String(budgetInitialDate.getInterval(toDate: budgetEndingDate, component: .day))) days"
            } else {
                remainingDays = getTimerCountdown(budgetInitialDate: budgetInitialDate, budgetEndingDate: budgetEndingDate)
            }

        default:
            return ""
        }
        return remainingDays
    }
    
    private func getTimerCountdown(budgetInitialDate: Date, budgetEndingDate: Date) -> String {
        var timeRemaining = ""
        return timeRemaining
    }


    @IBAction func addMoneyAction(_ sender: Any) {
        if let addMoneyTableViewController = storyboard?.instantiateViewController(identifier: R.storyboard.main.addMoneyTableViewController.identifier) as? AddMoneyTableViewController {
            addMoneyTableViewController.budget = self.budget
            navigationController?.pushViewController(addMoneyTableViewController, animated: true)
        }
    }
    
    @IBAction func addExpenseAction(_ sender: Any) {
        if let addExpensesTableViewController = storyboard?.instantiateViewController(identifier: R.storyboard.main.addExpensesTableViewController.identifier) as? AddExpensesTableViewController {
            navigationController?.pushViewController(addExpensesTableViewController, animated: true)
        }
    }
    
}
