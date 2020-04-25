//
//  BudgetTableViewCell.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {

    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetAmountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setupCell(budget: Budget) {
        self.budgetNameLabel.text = budget.name
        self.budgetAmountLabel.text = String(budget.amount)
    }
    
}
