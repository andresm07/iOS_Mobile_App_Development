//
//  HistoryListViewController.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryListViewController: UIViewController {
    
    @IBOutlet weak var historyListTableView: UITableView!
    
    let budgetTableViewHeaderIdentifier = "BudgetTableViewHeader"
    let transactionTableViewCellIdentifier = "TransactionTableViewCell"
    var budgets: Results<Budget>?
    var currentUser: User?
    let realmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.historyListTableView.delegate = self
        self.historyListTableView.dataSource = self
        
        registerCustomCells()
        
        let userDefaults = UserDefaults.standard
        let activeUser = self.realmManager.getUser(username: userDefaults.object(forKey: "Username") as! String)?.first
        if activeUser != nil {
            self.currentUser = activeUser
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateBudgetList()
    }
    
    private func updateBudgetList() {
        let budgets = self.realmManager.getAllBudgets()
        //let budgets = self.realmManager.getAllUserBudgets(user: self.currentUser!)
        if let budgets = budgets, budgets.isEmpty {
            updateBudgetList()
        } else {
            self.budgets = budgets
            self.historyListTableView.reloadData()
        }
    }
    
    private func registerCustomCells() {
        self.historyListTableView.register(UINib(resource: R.nib.transactionTableViewCell), forCellReuseIdentifier: R.nib.transactionTableViewCell.name)
        self.historyListTableView.register(UINib(resource: R.nib.budgetTableViewHeader), forHeaderFooterViewReuseIdentifier: R.nib.budgetTableViewHeader.name)
    }
    
    
}

extension HistoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.budgets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.budgets?[section].transactions.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.historyListTableView.dequeueReusableCell(withIdentifier: self.transactionTableViewCellIdentifier) as? TransactionTableViewCell else
        {
            return UITableViewCell()
        }
        cell.setupCell(transaction: (self.budgets?[indexPath.section].transactions[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = self.historyListTableView.dequeueReusableHeaderFooterView(withIdentifier: R.nib.budgetTableViewHeader.name) as? BudgetTableViewHeader else {
            return UIView()
        }
        cell.setupCell(budget: (self.budgets?[section])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteTitle = NSLocalizedString("Delete", comment: "Delete")
        let deleteAction = UITableViewRowAction(style: .destructive, title: deleteTitle) { (actiion, indexPath) in
            if let transaction = self.budgets?[indexPath.section].transactions[indexPath.row] {
                self.realmManager.updateMainBudgetAmountDeletedTransaction(transaction: transaction, budget: (self.budgets?[indexPath.section])!)
                self.realmManager.deleteTransaction(transaction: transaction)
                self.historyListTableView.beginUpdates()
                self.historyListTableView.deleteRows(at: [indexPath], with: .fade)
                self.historyListTableView.endUpdates()
                self.historyListTableView.reloadData()
            }
        }
        return [deleteAction]
    }
    
}
