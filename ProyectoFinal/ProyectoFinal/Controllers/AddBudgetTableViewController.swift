//
//  AddBudgetTableViewController.swift
//  ProyectoFinal
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol AddBudgetTableViewControllerProtocol: class {
    func addBudget(user: User, budget: Budget)
}

class AddBudgetTableViewController: UITableViewController {

    
    @IBOutlet weak var budgetNameTextField: UITextField!
    @IBOutlet weak var budgetPeriodicityPickerTextField: UITextField!
    @IBOutlet weak var startDatePickerTextField: UITextField!
    @IBOutlet weak var initialAmoutTextField: UITextField!
    @IBOutlet weak var rolloverSwitch: UISwitch!
    @IBOutlet weak var userNameLabel: UILabel!
    
    weak var delegate: AddBudgetTableViewControllerProtocol?
    
    var budget: Budget?
    let realmManager = RealmManager()
    let periodicityPickerView = UIPickerView()
    let periodicityOptions = ["Weekly", "Quarterly", "Monthly"]
    var selectedPeriodicity: String?
    let datePickerView = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializePickerViews()
        dismissPickerViews()
        showDatePicker()
        
        if let budget = self.budget {
            self.userNameLabel.text = "Edit Budget"
            self.budgetNameTextField.text = budget.name
            self.budgetPeriodicityPickerTextField.text = budget.periodicity
            self.budgetPeriodicityPickerTextField.isUserInteractionEnabled = false
            self.startDatePickerTextField.text = budget.initialDate.toString(dateFormat: "dd/MM/yyyy")
            self.startDatePickerTextField.isUserInteractionEnabled = false
            self.initialAmoutTextField.text = String(budget.amount)
            self.initialAmoutTextField.isUserInteractionEnabled = false
            self.rolloverSwitch.setOn(budget.rollover, animated: true)
            editBudgetNavigationButton()
        } else {
            self.userNameLabel.text = "Add New Budget"
            saveBudgetNavitagionButton()
        }
        
    }
    
    
    @IBAction func rolloverSwitchAction(_ sender: UISwitch) {
        
    }
    
    private func editBudgetNavigationButton() {
        let editBudgetNavigationButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editBudgetAction(sender:)))
        navigationItem.rightBarButtonItem = editBudgetNavigationButton
    }
    
    @objc func editBudgetAction(sender: UIBarButtonItem) {
        let budgetIdentifier: String = self.budget!.identifier
        let budgetName: String = self.budget!.name
        let activeBudget = self.realmManager.getBudget(identifier: budgetIdentifier, name: budgetName)?.first
        if let newBudgetName = self.budgetNameTextField.text, newBudgetName.count > 0 {
            self.realmManager.updateBudgetNameAndRollover(budget: activeBudget!, name: newBudgetName, rollover: self.rolloverSwitch.isOn)
            navigationController?.popViewController(animated: true)
        } else {
            let alertController = UIAlertController(title: "Error", message: "Fill out budget name", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    private func saveBudgetNavitagionButton() {
        let saveBudgetNavigationButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBudgetAction(sender:)))
        navigationItem.rightBarButtonItem = saveBudgetNavigationButton
    }
    
    @objc func saveBudgetAction(sender: UIBarButtonItem) {
        if let budgetName = self.budgetNameTextField.text, budgetName.count > 0, let budgetPeriodicity = self.budgetPeriodicityPickerTextField.text, budgetPeriodicity.count > 0, let budgetInitialDate = self.startDatePickerTextField.text, budgetInitialDate.count > 0, let budgetInitialAmountText = self.initialAmoutTextField.text, budgetInitialAmountText.count > 0 {
            let budget = Budget(name: budgetName, periodicity: budgetPeriodicity, initialDate: budgetInitialDate.stringToDate(), initialAmount: budgetInitialAmountText.floatValue, rollover: self.rolloverSwitch.isOn)
            let userDefaults = UserDefaults.standard
            let activeUser = (self.realmManager.getUser(username: userDefaults.object(forKey: "Username") as! String)?.first)!
            self.delegate?.addBudget(user: activeUser, budget: budget)
        } else {
            let alertController = UIAlertController(title: "Error", message: "Fill out data", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    private func showDatePicker() {
        self.datePickerView.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        self.startDatePickerTextField.inputAccessoryView = toolbar
        self.startDatePickerTextField.inputView = self.datePickerView
        
    }
    
    @objc func doneDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.startDatePickerTextField.text = formatter.string(from: self.datePickerView.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }

}

extension AddBudgetTableViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.periodicityOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.periodicityOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedPeriodicity = self.periodicityOptions[row]
        self.budgetPeriodicityPickerTextField.text = self.selectedPeriodicity
    }
    
    func initializePickerViews() {
        self.periodicityPickerView.delegate = self
        self.budgetPeriodicityPickerTextField.inputView = self.periodicityPickerView
    }
    
    func dismissPickerViews() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolbar.setItems([button], animated: true)
        toolbar.isUserInteractionEnabled = true
        self.budgetPeriodicityPickerTextField.inputAccessoryView = toolbar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
    
}
