//
//  ConfigurationViewController.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController {
    
    var currentUser: User?
    let realmManager = RealmManager()
    
    @IBOutlet weak var appVersionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appVersionLabel.text = "\(Bundle.main.appName) v \(Bundle.main.versionNumber) (Build \(Bundle.main.buildNumber))"
        
        let userDefaults = UserDefaults.standard
        let activeUser = self.realmManager.getUser(username: userDefaults.object(forKey: "Username") as! String)?.first
        if activeUser != nil {
            self.currentUser = activeUser
        }
        
    }
    

    @IBAction func deleteDatabaseAction(_ sender: Any) {
        self.realmManager.deleteUserBudgets(user: self.currentUser!)
    }
}
