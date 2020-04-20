//
//  TabBarViewController.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
    }
    
    @objc func didBecomeActive() {
        //significa que el app viene de background
    }
    
    @objc func didEnterBackground() {
        
        //significa que el app vara para background
    }
    
}
