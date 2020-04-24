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
    var currentUser: User?
    let realmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.budgetListTableView.delegate = self
        self.budgetListTableView.dataSource = self
        
        registerCustomCells()
        addBudgetNavitationButton()
        addLogoutNavigationButton()
        
        let userDefaults = UserDefaults.standard
        let activeUser = self.realmManager.getUser(username: userDefaults.object(forKey: "Username") as! String)?.first
        if activeUser != nil {
            self.currentUser = activeUser
        }
        
        getBudgets()
        
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
            self.budgetListTableView.reloadData()
        }
    }
    
    private func registerCustomCells() {
        self.budgetListTableView.register(UINib(resource: R.nib.budgetTableViewCell), forCellReuseIdentifier: R.nib.budgetTableViewCell.name)
    }
    
    private func addBudgetNavitationButton() {
        let addBudgetNavigationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBudgetAction(sender:)))
        navigationItem.rightBarButtonItem = addBudgetNavigationButton
    }
    
    @objc func addBudgetAction(sender: UIBarButtonItem) {
        if let addBudgetTableViewController = storyboard?.instantiateViewController(identifier: R.storyboard.main.addBudgetTableViewController.identifier) as? AddBudgetTableViewController {
            addBudgetTableViewController.delegate = self
            navigationController?.pushViewController(addBudgetTableViewController, animated: true)
        }
    }
    
    private func addLogoutNavigationButton() {
        let addLogoutNavigationButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(addLogoutAction(sender:)))
        navigationItem.leftBarButtonItem = addLogoutNavigationButton
    }
    
    @objc func addLogoutAction(sender: UIBarButtonItem) {
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    private func getBudgets() {
        let budgets = self.realmManager.getAllBudgets()
        //let budgets = self.realmManager.getAllUserBudgets(user: self.currentUser!)
        if let budgets = budgets, budgets.isEmpty {
            self.realmManager.insertBudget(name: "Peru", periodicity: "Monthly", initialAmount: 0.0, rollover: true)
            self.realmManager.insertBudget(name: "Semana Santa 2021", periodicity: "Weekly", initialAmount: 150.0, rollover: false)
            getBudgets()
        } else {
            self.budgets = budgets
            self.budgetListTableView.reloadData()
        }
    }

}

extension BudgetListViewController: AddBudgetTableViewControllerProtocol {
    func addBudget(budget: Budget) {
        self.realmManager.insertBudget(name: budget.name, periodicity: budget.periodicity, initialAmount: budget.initialAmount, rollover: budget.rollover)
        navigationController?.popViewController(animated: true)
        self.budgetListTableView.reloadData()
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
            cell.backgroundColor = UIColor(red: (255.0/255.0), green: 0.0, blue: 0.0, alpha: 0.7)
        } else {
            cell.backgroundColor = UIColor(red: (81.0/255.0), green: (193.0/255.0), blue: (120.0/255.0), alpha: 0.7)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let visualizeBudgetTableViewController = storyboard?.instantiateViewController(identifier: R.storyboard.main.visualizeBudgetTableViewController.identifier) as? VisualizeBudgetTableViewController {
            visualizeBudgetTableViewController.budget = self.budgets?[indexPath.row]
            navigationController?.pushViewController(visualizeBudgetTableViewController, animated: true)
        }
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            if let budget = self.budgets?[indexPath.row] {
//                self.realmManager.deleteBudget(budget: budget)
//                self.budgetListTableView.beginUpdates()
//                self.budgetListTableView.deleteRows(at: [indexPath], with: .fade)
//                self.budgetListTableView.endUpdates()
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteTitle = NSLocalizedString("Delete", comment: "Delete")
        let deleteAction = UITableViewRowAction(style: .destructive, title: deleteTitle) { (actiion, indexPath) in
            if let budget = self.budgets?[indexPath.row] {
                self.realmManager.deleteBudget(budget: budget)
                self.budgetListTableView.beginUpdates()
                self.budgetListTableView.deleteRows(at: [indexPath], with: .fade)
                self.budgetListTableView.endUpdates()
            }
        }
        
        let editTitle = NSLocalizedString("Edit", comment: "Edit")
        let editAction = UITableViewRowAction(style: .normal, title: editTitle) { (action, indexPath) in
            if let addBudgetTableViewController = self.storyboard?.instantiateViewController(identifier: R.storyboard.main.addBudgetTableViewController.identifier) as? AddBudgetTableViewController {
            addBudgetTableViewController.budget = self.budgets?[indexPath.row]
                self.navigationController?.pushViewController(addBudgetTableViewController, animated: true)
            }
        }
        
        return [editAction, deleteAction]
    }
    
}
