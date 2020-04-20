//
//  AddExpensesTableViewController.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class AddExpensesTableViewController: UITableViewController {
    
    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetAmountTextField: UITextField!
    @IBOutlet weak var budgetDetailsTextField: UITextField!
    
    var budget: Budget?
    let realmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let budget = self.budget {
            self.budgetNameLabel.text = budget.name
        }
        
    }

    @IBAction func saveExpenseAction(_ sender: Any) {
        let transaction = Transaction(detail: self.budgetDetailsTextField.text!, amount: self.budgetAmountTextField.text!.floatValue, type: "Expense")
        self.realmManager.addTransactionToBudget(transaction: transaction, budget: self.budget!)
        self.realmManager.updateMainBudgetAmount(transaction: transaction, budget: self.budget!)
        navigationController?.popViewController(animated: true)
    }
}
