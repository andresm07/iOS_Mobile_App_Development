//
//  ViewController.swift
//  Quiz3
//
//  Created by admin on 4/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var items: Results<Item>?
    let itemCellIdentifier = "ItemTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        registerCustomCells()
        createItems()
    }

    
    private func createItems() {
        
        let realmManager = RealmManager()
        let items = realmManager.getAllItems()
        if let items = items, items.isEmpty {
            realmManager.insertItem(tagNumber: 0, name: "Pesas", quantity: 50)
            realmManager.insertItem(tagNumber: 1, name: "Banca", quantity: 10)
            realmManager.insertItem(tagNumber: 2, name: "Barra Olimpica", quantity: 10)
            realmManager.insertItem(tagNumber: 3, name: "Kettlebell", quantity: 25)
            realmManager.insertItem(tagNumber: 4, name: "Disco", quantity: 30)
            realmManager.insertItem(tagNumber: 5, name: "Barra Z", quantity: 15)
            realmManager.insertItem(tagNumber: 6, name: "Maquina Dominadas", quantity: 2)
            realmManager.insertItem(tagNumber: 7, name: "Bicicleta", quantity: 30)
            realmManager.insertItem(tagNumber: 8, name: "Banda", quantity: 30)
            realmManager.insertItem(tagNumber: 9, name: "Maquina Remo", quantity: 1)
            print("ITEMS ADDED")
            createItems()
        } else {
            self.items = items
            self.tableView.reloadData()
        }
    }
    
    private func registerCustomCells() {
        let nib = UINib(nibName: self.itemCellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.itemCellIdentifier)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.itemCellIdentifier) as? ItemTableViewCell else
        {
            return UITableViewCell()
        }
        if let item = self.items?[indexPath.row] {
            cell.setupCell(item: item)
        }
        return cell
    }
    
}


