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
    
    var owners: Results<Owner>?
    
    let animalCellIdentifier = "AnimalDisplayTableViewCell"
    let realmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        registerCustomCells()
        addAnimalNavigationButton()
        createOwners()
    }
    
    private func createOwners() {
        let owners = self.realmManager.getAllOwners()
        if let owners = owners, owners.isEmpty {
            self.realmManager.insertOwner(name: "Andres Miranda", province: "Heredia", phoneNumber: "87078389")
            self.realmManager.insertOwner(name: "Mazel Abarca", province: "Cartago", phoneNumber: "60454870")
            print("OWNERS ADDED")
            createOwners()
        } else {
            self.owners = owners
            self.tableView.reloadData()
        }
    }
    
    private func registerCustomCells() {
        self.tableView.register(UINib(resource: R.nib.animalDisplayTableViewCell), forCellReuseIdentifier: R.nib.animalDisplayTableViewCell.name)
        self.tableView.register(UINib(resource: R.nib.ownerDisplayHeader), forHeaderFooterViewReuseIdentifier: R.nib.ownerDisplayHeader.name)
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
    func addAnimal(animal: Animal, owner: Owner) {
        self.realmManager.addAnimalToOwner(animal: animal, owner: owner)
        navigationController?.popViewController(animated: true)
        self.tableView.reloadData()
    }
}

extension AnimalListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.owners?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.owners?[section].animals.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: self.animalCellIdentifier) as? AnimalDisplayTableViewCell else
        {
            return UITableViewCell()
        }
        cell.setupCell(owner: (self.owners?[indexPath.section])!, animal: (self.owners?[indexPath.section].animals[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: R.nib.ownerDisplayHeader.name) as? OwnerDisplayHeader else {
            return UIView()
        }
        cell.setupCell(owner: (self.owners?[section])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let addAnimalTableViewController = storyboard?.instantiateViewController(identifier: "AddAnimalTableViewController") as? AddAnimalTableViewController {
            //addAnimalTableViewController.news = self.category?.news[indexPath.row]
            navigationController?.pushViewController(addAnimalTableViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let animal = owners?[indexPath.section].animals[indexPath.row] {
                self.realmManager.deleteAnimal(animal: animal)
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.endUpdates()
            }
        }
    }
}
