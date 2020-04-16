//
//  HistoryListViewController.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class HistoryListViewController: UIViewController {

    @IBOutlet weak var historyListTableView: UITableView!
    
    let budgetTableViewHeaderIdentifier = "BudgetTableViewHeader"
    let transactionTableViewCellIdentifier = "TransactionTableViewCell"
    var budgets = [Budget]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.historyListTableView.delegate = self
        self.historyListTableView.dataSource = self
        
        registerCustomCells()
        
    }
    
    private func registerCustomCells() {
        self.historyListTableView.register(UINib(resource: R.nib.transactionTableViewCell), forCellReuseIdentifier: R.nib.transactionTableViewCell.name)
        self.historyListTableView.register(UINib(resource: R.nib.budgetTableViewHeader), forHeaderFooterViewReuseIdentifier: R.nib.budgetTableViewHeader.name)
    }
    

}

extension HistoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.budgets.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.budgets[section].transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.historyListTableView.dequeueReusableCell(withIdentifier: self.transactionTableViewCellIdentifier) as? TransactionTableViewCell else
        {
            return UITableViewCell()
        }
        cell.setupCell(transaction: self.budgets[indexPath.section].transactions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = self.historyListTableView.dequeueReusableHeaderFooterView(withIdentifier: R.nib.budgetTableViewHeader.name) as? BudgetTableViewHeader else {
            return UIView()
        }
        cell.setupCell(budget: self.budgets[section])
        return cell
    }
    
    
}
