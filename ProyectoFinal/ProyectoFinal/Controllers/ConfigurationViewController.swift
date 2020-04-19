//
//  ConfigurationViewController.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController {
    
    
    @IBOutlet weak var appVersionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject?
        	
        let version = nsObject as! String
        
        self.appVersionLabel.text = version
        
    }
    

    @IBAction func deleteDatabaseAction(_ sender: Any) {
    }
}
