//
//  AnimalListViewController.swift
//  AsignacionAdicional
//
//  Created by admin on 3/28/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class AnimalListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let animalCellIdentifier = "AnimalDisplayTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        registerCustomCells()
        addAnimalNavigationButton()
    }
    
    private func registerCustomCells() {
        let nib = UINib(nibName: self.animalCellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.animalCellIdentifier)
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
        
    }
}

extension AnimalListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: self.animalCellIdentifier) as? AnimalDisplayTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
}
