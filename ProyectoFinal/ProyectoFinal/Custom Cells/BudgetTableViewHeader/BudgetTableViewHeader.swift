//
//  BudgetTableViewHeader.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class BudgetTableViewHeader: UITableViewHeaderFooterView {

    
    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetAmountLabel: UILabel!
    
    public func setupCell(budget: Budget) {
        self.budgetNameLabel.text = budget.name
        self.budgetAmountLabel.text = String(budget.amount)
    }
}
