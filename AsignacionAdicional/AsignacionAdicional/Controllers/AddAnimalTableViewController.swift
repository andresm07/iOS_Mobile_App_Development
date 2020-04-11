//
//  AddAnimalViewController.swift
//  AsignacionAdicional
//
//  Created by admin on 3/28/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RealmSwift

protocol AddAnimalTableViewControllerProtocol: class {
    func addAnimal(animal: Animal, owner: Owner)
}

class AddAnimalTableViewController: UITableViewController{
    
    weak var delegate: AddAnimalTableViewControllerProtocol?
    
    
    @IBOutlet weak var animalTypeDropDown: UITextField!
    @IBOutlet weak var ownerNameTextField: UITextField!
    @IBOutlet weak var ownerPhoneNumberTextField: UITextField!
    @IBOutlet weak var ownerProvinceDropDown: UITextField!
    
    var animal: Animal?
    var owner: Owner?
    var selectedAnimalType: String?
    var animalTypeList = ["Dog", "Cat"]
    var selectedProvince: String?
    var provinceList = ["Heredia", "Cartago", "Alajuela", "Limon", "Puntarenas", "Guanacaste", "San Jose"]
    
    var animalTypePickerView = UIPickerView()
    var provincePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializePickerViews()
        dismissPickerViews()

        // Do any additional setup after loading the view.
        if let animal = self.animal, let owner = self.owner {
            self.animalTypeDropDown.text = animal.animalType
            self.animalTypeDropDown.isUserInteractionEnabled = false
            self.ownerNameTextField.text = owner.name
            self.ownerNameTextField.isUserInteractionEnabled = false
            self.ownerPhoneNumberTextField.text = owner.phoneNumber
            self.ownerPhoneNumberTextField.isUserInteractionEnabled = false
            self.ownerProvinceDropDown.text = owner.province
            self.ownerProvinceDropDown.isUserInteractionEnabled = false
        } else {
            saveAnimalNavigationButton()
        }
    }
    
    func saveAnimalNavigationButton() {
        let saveAnimalNavigationButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAnimalAction(sender:)))
        navigationItem.rightBarButtonItem = saveAnimalNavigationButton
    }
    
    @objc func saveAnimalAction(sender: UIBarButtonItem) {
        if let ownerName = self.ownerNameTextField.text, ownerName.count > 0, self.animalTypeDropDown.text!.count > 0, self.ownerPhoneNumberTextField.text!.count > 0, self.ownerProvinceDropDown.text!.count > 0 {
            
            let realmManager = RealmManager()
            let owner = Owner(name: ownerName, province: self.ownerProvinceDropDown.text!, phoneNumber: self.ownerPhoneNumberTextField.text!)
            let animal = Animal(animalType: self.animalTypeDropDown.text!, imageName: self.animalTypeDropDown.text!)
            if realmManager.findOwner(owner: owner) {
                owner.animals.append(animal)
            } else {
                realmManager.insertOwner(name: ownerName, province: self.ownerProvinceDropDown.text!, phoneNumber: self.ownerProvinceDropDown.text!)
                let newOwner = Owner(name: ownerName, province: self.ownerProvinceDropDown.text!, phoneNumber: self.ownerProvinceDropDown.text!)
                realmManager.addAnimalToOwner(animal: animal, owner: newOwner)
            }
            
        } else {
            let alertController = UIAlertController(title: "Error", message: "Debe llenar los datos", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    }

}

extension AddAnimalTableViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.animalTypePickerView {
            return self.animalTypeList.count
        }
        else {
            return self.provinceList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.animalTypePickerView {
            return self.animalTypeList[row]
        } else {
            return self.provinceList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.animalTypePickerView {
            self.selectedAnimalType = self.animalTypeList[row]
            self.animalTypeDropDown.text = self.selectedAnimalType
        } else {
            self.selectedProvince = self.provinceList[row]
            self.ownerProvinceDropDown.text = self.selectedProvince
        }
    }
    
    func initializePickerViews() {
        self.animalTypePickerView.delegate = self
        self.animalTypeDropDown.inputView = self.animalTypePickerView
        self.provincePickerView.delegate = self
        self.ownerProvinceDropDown.inputView = self.provincePickerView
    }
    
    func dismissPickerViews() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolbar.setItems([button], animated: true)
        toolbar.isUserInteractionEnabled = true
        self.animalTypeDropDown.inputAccessoryView = toolbar
        self.ownerProvinceDropDown.inputAccessoryView = toolbar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
}
