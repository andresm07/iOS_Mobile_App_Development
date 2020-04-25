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
    
    var timer: Timer?
    var totalTime: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let budget = self.budget {
            self.budgetNameLabel.text = budget.name
            self.budgetAmountLabel.text = String(budget.amount)
            self.daysRemainingLabel.text = "Calculating"
            let budgetInitialDate: Date = budget.initialDate
            var budgetEndingDate: Date
            let currentDate: Date = Date()
            switch budget.periodicity {
            case "Weekly":
                budgetEndingDate = (budgetInitialDate + 7.days)
                if currentDate < budgetEndingDate {
                    let hours = currentDate.getInterval(toDate: budgetEndingDate, component: .hour)
                    if hours > 24 {
                        self.daysRemainingLabel.text = getRemainingDays(budget: budget)
                    } else {
                        getTimerCountdown(budgetInitialDate: budgetInitialDate, budgetEndingDate: budgetEndingDate)
                    }
                }
            case "Quarterly":
                budgetEndingDate = (budgetInitialDate + 15.days)
                if currentDate < budgetEndingDate {
                    let hours = currentDate.getInterval(toDate: budgetEndingDate, component: .hour)
                    if hours > 24 {
                        self.daysRemainingLabel.text = getRemainingDays(budget: budget)
                    } else {
                        getTimerCountdown(budgetInitialDate: budgetInitialDate, budgetEndingDate: budgetEndingDate)
                    }
                }
            case "Monthly":
                budgetEndingDate = (budgetInitialDate + 1.months)
                if currentDate < budgetEndingDate {
                    let hours = currentDate.getInterval(toDate: budgetEndingDate, component: .hour)
                    if hours > 24 {
                        self.daysRemainingLabel.text = getRemainingDays(budget: budget)
                    } else {
                        getTimerCountdown(budgetInitialDate: budgetInitialDate, budgetEndingDate: budgetEndingDate)
                    }
                }
            default:
                print("")
            }
        }
    }
    
    @IBAction func addMoneyAction(_ sender: Any) {
        if let addMoneyTableViewController = storyboard?.instantiateViewController(identifier: R.storyboard.main.addMoneyTableViewController.identifier) as? AddMoneyTableViewController {
            addMoneyTableViewController.budget = self.budget
            navigationController?.pushViewController(addMoneyTableViewController, animated: true)
        }
    }
    
    @IBAction func addExpenseAction(_ sender: Any) {
        if let addExpensesTableViewController = storyboard?.instantiateViewController(identifier: R.storyboard.main.addExpensesTableViewController.identifier) as? AddExpensesTableViewController {
            addExpensesTableViewController.budget = self.budget
            navigationController?.pushViewController(addExpensesTableViewController, animated: true)
        }
    }
    
    public func getRemainingDays(budget: Budget) -> String{
        var remainingDays = ""
        let budgetInitialDate: Date = budget.initialDate
        var budgetEndingDate: Date
        let currentDate: Date = Date()
        switch budget.periodicity {
        case "Weekly":
            budgetEndingDate = (budgetInitialDate + 7.days)
            if currentDate < budgetEndingDate {
                let hours = currentDate.getInterval(toDate: budgetEndingDate, component: .hour)
                if hours > 24 {
                    remainingDays = "\(String(budgetInitialDate.getInterval(toDate: budgetEndingDate, component: .day))) days"
                }
            }
            
        case "Quarterly":
            budgetEndingDate = (budgetInitialDate + 15.days)
            if currentDate < budgetEndingDate {
                let hours = currentDate.getInterval(toDate: budgetEndingDate, component: .hour)
                if hours > 24 {
                    remainingDays = "\(String(budgetInitialDate.getInterval(toDate: budgetEndingDate, component: .day))) days"
                }
            }
            
        case "Monthly":
            budgetEndingDate = (budgetInitialDate + 1.months)
            if currentDate < budgetEndingDate {
                let hours = currentDate.getInterval(toDate: budgetEndingDate, component: .hour)
                if hours > 24 {
                    remainingDays = "\(String(budgetInitialDate.getInterval(toDate: budgetEndingDate, component: .day))) days"
                }
            }

        default:
            return ""
        }
        return remainingDays
    }
    
    private func getTimerCountdown(budgetInitialDate: Date, budgetEndingDate: Date) {
        let currentDate: Date = Date()
        if currentDate > (budgetEndingDate - 24.hours) {
            let totalRemainingSeconds = currentDate.getInterval(toDate: budgetEndingDate, component: .second)
            self.totalTime = Int(totalRemainingSeconds)
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateTimer() {
        self.daysRemainingLabel.text = timeFormatted(self.totalTime!)
        if self.totalTime != 0 {
            self.totalTime! -= 1
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
            }
        }
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        let hours: Int = ((totalSeconds / 60) / 60) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
