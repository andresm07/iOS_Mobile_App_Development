//
//  AddAnimalViewController.swift
//  AsignacionAdicional
//
//  Created by admin on 3/28/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol AddAnimalTableViewControllerProtocol: class {
    func addAnimal(animal: Animal)
}

class AddAnimalTableViewController: UITableViewController{
    
    weak var delegate: AddAnimalTableViewControllerProtocol?
    
    
    @IBOutlet weak var animalTypeDropDown: UITextField!
    @IBOutlet weak var ownerNameTextField: UITextField!
    @IBOutlet weak var ownerPhoneNumberTextField: UITextField!
    @IBOutlet weak var ownerProvinceDropDown: UITextField!
    
    var animal: Animal?
    var selectedAnimalType: String?
    var animalTypeList = ["Dog", "Cat"]
    var selectedProvince: String?
    var provinceList = ["Heredia", "Cartago", "Alajuela", "Limon", "Puntarenas", "Guanacaste", "San Jose"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAnimalTypePickerView()
        dismissAnimalTypePickerView()

        // Do any additional setup after loading the view.
        if let animal = self.animal {
            //self.animalTypePicker.text = animal.animalType
            self.animalTypeDropDown.isUserInteractionEnabled = false
            //self.ownerNameTextField.text = animal.owners
            self.ownerNameTextField.isUserInteractionEnabled = false
            //self.ownerPhoneNumberTextField.text = animal.owners
            self.ownerPhoneNumberTextField.isUserInteractionEnabled = false
            //self.ownerProvincePicker.text = animal.owners
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
        if let ownerName = self.ownerNameTextField.text, ownerName.count > 0 {
            
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
        return animalTypeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return animalTypeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAnimalType = animalTypeList[row]
        animalTypeDropDown.text = selectedAnimalType
    }
    
    func createAnimalTypePickerView() {
        let animalTypePickerView = UIPickerView()
        animalTypePickerView.delegate = self
        animalTypeDropDown.inputView = animalTypePickerView
    }
    
    func dismissAnimalTypePickerView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolbar.setItems([button], animated: true)
        toolbar.isUserInteractionEnabled = true
        animalTypeDropDown.inputAccessoryView = toolbar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
}
