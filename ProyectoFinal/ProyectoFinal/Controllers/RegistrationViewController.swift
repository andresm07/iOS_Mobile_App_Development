//
//  RegistrationViewController.swift
//  ProyectoFinal
//
//  Created by admin on 4/19/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let realmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func registrationButtonAction(_ sender: Any) {
        if let name = self.nameTextField.text, name.count > 0, let username = self.usernameTextField.text, username.count > 0, let password = self.passwordTextField.text, password.count > 0{
            if self.realmManager.usernameExists(username: username)!.count == 0 {
                self.realmManager.insertUser(name: name, username: username, password: password)
                if let loginViewController = storyboard?.instantiateViewController(identifier: R.storyboard.main.loginViewController.identifier) {
                    loginViewController.modalPresentationStyle = .fullScreen
                    present(loginViewController, animated: true, completion: nil)
                }
            } else {
                let alertController = UIAlertController(title: "Error", message: "Username already taken", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertAction)
                present(alertController, animated: true, completion: nil)
            }
            
        } else {
            let alertController = UIAlertController(title: "Error", message: "Please fill out data", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func backActionButton(_ sender: Any) {
        if let loginViewController = storyboard?.instantiateViewController(identifier: R.storyboard.main.loginViewController.identifier) {
            loginViewController.modalPresentationStyle = .fullScreen
            present(loginViewController, animated: true, completion: nil)
        }
    }
    
}
