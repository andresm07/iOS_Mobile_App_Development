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
        let confirmationAlertController = UIAlertController(title: "Delete App Data?", message: "All data will be lost.", preferredStyle: .alert)
            confirmationAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                self.realmManager.deleteUserBudgets(user: self.currentUser!)
                print("OK")
            }))
            confirmationAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Cancel")
            }))
            present(confirmationAlertController, animated: true, completion: nil)
        }
}
    

