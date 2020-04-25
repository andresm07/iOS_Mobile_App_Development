//
//  TabBarViewController.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftDate

class TabBarViewController: UITabBarController {
    
    var budgets: Results<Budget>?
    let realmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
    }
    
    @objc func didBecomeActive() {
        updateBudgetList()
        self.budgets?.forEach { budget in
            if budget.rollover {
                BudgetRolloverManager.restartBudgetWithRollover(budget: budget)
            } else if !budget.rollover {
                BudgetRolloverManager.restartBudgetWithoutRollover(budget: budget)
            }
        }
    }
    
    @objc func didEnterBackground() {
        
    }
    
    private func updateBudgetList() {
        let budgets = self.realmManager.getAllBudgets()
        if let budgets = budgets, budgets.isEmpty {
            updateBudgetList()
        } else {
            self.budgets = budgets
        }
    }
    
}
