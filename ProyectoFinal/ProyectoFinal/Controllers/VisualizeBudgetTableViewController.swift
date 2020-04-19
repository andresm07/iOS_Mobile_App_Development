//
//  VisualizeBudgetTableViewController.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

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
            navigationController?.pushViewController(addExpensesTableViewController, animated: true)
        }
    }
    
}
