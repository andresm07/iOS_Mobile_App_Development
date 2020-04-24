//
//  LoginViewController.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userList: Results<User>?
    let realmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //updateUserList()
    }
    
    private func getUsers() {
        let users = self.realmManager.getAllUsers()
        if let users = users, users.isEmpty {
            getUsers()
        } else {
            self.userList = users
        }
    }
    
    private func updateUserList() {
        let users = self.realmManager.getAllUsers()
        if let users = users, users.isEmpty {
            updateUserList()
        } else {
            self.userList = users
        }
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        validateLogin()
    }
    
    private func validateLogin() {
        let realmManager = RealmManager()
        if let username = self.usernameTextField.text, username.count > 0, let password = self.passwordTextField.text, password.count > 0 {
            if realmManager.validateLogin(username: username, password: password) {
                if let tabBarController = storyboard?.instantiateViewController(identifier: R.storyboard.main.tabBarViewController.identifier) {
                    let userDefaults = UserDefaults.standard
                    userDefaults.set(username, forKey: "Username")
                    self.usernameTextField.text = nil
                    self.passwordTextField.text = nil
                    tabBarController.modalPresentationStyle = .fullScreen
                    present(tabBarController, animated: true, completion: nil)
                }
            } else {
                let alertController = UIAlertController(title: "Error", message: "Invalid Username or Password", preferredStyle: .alert)
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
    
    
    @IBAction func registerButtonAction(_ sender: Any) {
        if let registrationViewController = storyboard?.instantiateViewController(identifier: R.storyboard.main.registrationViewController.identifier) {
            registrationViewController.modalPresentationStyle = .fullScreen
            present(registrationViewController, animated: true, completion: nil)
        }
    }
    
}
