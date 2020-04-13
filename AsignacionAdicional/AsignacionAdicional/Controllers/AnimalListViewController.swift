//
//  AnimalListViewController.swift
//  AsignacionAdicional
//
//  Created by admin on 3/28/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RealmSwift

class AnimalListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var animals: Results<Animal>?
    
    let animalCellIdentifier = "AnimalDisplayTableViewCell"
    let realmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        registerCustomCells()
        addAnimalNavigationButton()
        createData()
    }
    
    private func createData() {
        let animals = self.realmManager.getAllAnimals()
        if let animals = animals, animals.isEmpty {
            self.realmManager.insertAnimal(animalType: "Dog", imageName: "Dog", name: "Andres Miranda", province: "Heredia", phoneNumber: "87078389")
            self.realmManager.insertAnimal(animalType: "Cat", imageName: "Cat", name: "Andres Miranda", province: "Cartago", phoneNumber: "87078389")
            self.realmManager.insertAnimal(animalType: "Dog", imageName: "Dog", name: "Juan Perez", province: "Limon", phoneNumber: "88888888")
            print("ANIMALS ADDED")
            createData()
        } else {
            self.animals = animals
            self.tableView.reloadData()
        }
    }
    
    private func registerCustomCells() {
        self.tableView.register(UINib(resource: R.nib.animalDisplayTableViewCell), forCellReuseIdentifier: R.nib.animalDisplayTableViewCell.name)
        //self.tableView.register(UINib(resource: R.nib.ownerDisplayHeader), forHeaderFooterViewReuseIdentifier: R.nib.ownerDisplayHeader.name)
    }
    
    func addAnimalNavigationButton() {
        let addAnimalNavigationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAnimalAction(sender:)))
        navigationItem.rightBarButtonItem = addAnimalNavigationButton
    }
    
    @objc func addAnimalAction(sender: UIBarButtonItem) {
        if let addAnimalTableViewController = storyboard?.instantiateViewController(identifier: "AddAnimalTableViewController") as? AddAnimalTableViewController {
            addAnimalTableViewController.delegate = self
            navigationController?.pushViewController(addAnimalTableViewController, animated: true)
        }
    }

}

extension AnimalListViewController: AddAnimalTableViewControllerProtocol {
    func addAnimal(animal: Animal) {
        self.realmManager.insertAnimal(animalType: animal.animalType, imageName: animal.imageName, name: animal.name, province: animal.province, phoneNumber: animal.phoneNumber)
        navigationController?.popViewController(animated: true)
        self.tableView.reloadData()
    }
}

extension AnimalListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: self.animalCellIdentifier) as? AnimalDisplayTableViewCell else
        {
            return UITableViewCell()
        }
        cell.setupCell(animal: (self.animals?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let addAnimalTableViewController = storyboard?.instantiateViewController(identifier: "AddAnimalTableViewController") as? AddAnimalTableViewController {
            addAnimalTableViewController.animal = self.animals?[indexPath.row]
            navigationController?.pushViewController(addAnimalTableViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let animal = self.animals?[indexPath.row] {
                self.realmManager.deleteAnimal(animal: animal)
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.endUpdates()
            }
        }
    }
}
