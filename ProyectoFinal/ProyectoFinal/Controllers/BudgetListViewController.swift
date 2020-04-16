//
//  BudgetListViewController.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RealmSwift

class BudgetListViewController: UIViewController {

    @IBOutlet weak var budgetListTableView: UITableView!
    
    let budgetTableViewCellIdentifier = "BudgetTableViewCell"
    var budgets: Results<Budget>?
    let realmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.budgetListTableView.delegate = self
        self.budgetListTableView.dataSource = self
        
        registerCustomCells()
        addBudgetNavitationButton()
        getBudgets()
    }
    
    private func registerCustomCells() {
        let nib = UINib(nibName: self.budgetTableViewCellIdentifier, bundle: nil)
        self.budgetListTableView.register(nib, forCellReuseIdentifier: self.budgetTableViewCellIdentifier)
    }
    
    private func addBudgetNavitationButton() {
        let addBudgetNavigationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBudgetAction(sender:)))
        navigationItem.rightBarButtonItem = addBudgetNavigationButton
    }
    
    @objc func addBudgetAction(sender: UIBarButtonItem) {
        if let addBudgetTableViewController = storyboard?.instantiateViewController(identifier: "AddBudgetTableViewController") as? AddBudgetTableViewController {
            //addNewsViewController.delegate = self
            navigationController?.pushViewController(addBudgetTableViewController, animated: true)
        }
    }
    
    private func getBudgets() {
        let realmManager = RealmManager()
        let budgets = realmManager.getAllBudgets()
        if let budgets = budgets, budgets.isEmpty {
            self.realmManager.insertBudget(name: "Peru", periodicity: "Monthly", initialAmount: 0.0)
            self.realmManager.insertBudget(name: "Semana Santa 2021", periodicity: "Weekly", initialAmount: 150.0)
            getBudgets()
        } else {
            self.budgets = budgets
            self.budgetListTableView.reloadData()
        }
    }

}

extension BudgetListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.budgets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.budgetListTableView.dequeueReusableCell(withIdentifier: self.budgetTableViewCellIdentifier) as? BudgetTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(budget: (self.budgets?[indexPath.row])!)
        if (self.budgets?[indexPath.row].amount)! <= 0.0 {
            cell.backgroundColor = UIColor(red: 255.0, green: 0.0, blue: 0.0, alpha: 0.0)
        } else {
            cell.backgroundColor = UIColor(red: 153.0, green: 204.0, blue: 255.0, alpha: 0.0)
        }
        return cell
    }
    
    
}
