//
//  ConfigurationViewController.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController {
    
    var user: User?
    let realmManager = RealmManager()
    
    @IBOutlet weak var appVersionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appVersionLabel.text = "\(Bundle.main.appName) v \(Bundle.main.versionNumber) (Build \(Bundle.main.buildNumber))"
        
    }
    

    @IBAction func deleteDatabaseAction(_ sender: Any) {
        
    }
}
