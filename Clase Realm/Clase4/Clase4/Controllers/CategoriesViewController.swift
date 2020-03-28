//
//  CategoriesViewController.swift
//  Clase4
//
//  Created by admin on 3/20/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RealmSwift

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var categories: Results<Category>?
    
    let categoryCellIdentifier = "CategoryTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        registerCustomCells()
        createCategories()
    }
    
    private func createCategories() {
//        self.categories.append(Category(name: "Economy", imageName: "Economy", news: [News]()))
//        self.categories.append(Category(name: "Incidents", imageName: "Incident", news: [News]()))
//        self.categories.append(Category(name: "Sports", imageName: "Sports", news: [News]()))
//        self.categories.append(Category(name: "Technology", imageName: "Technology", news: [News]()))
        
        let realmManager = RealmManager()
        let categories = realmManager.getAllCategories()
        if let categories = categories, categories.isEmpty {
            realmManager.insertCategory(name: "Economy", imageName: "Economy")
            realmManager.insertCategory(name: "Incidents", imageName: "Incident")
            realmManager.insertCategory(name: "Sports", imageName: "Sports")
            realmManager.insertCategory(name: "Technology", imageName: "Tchnology")
            print("CATEGORIES ADDED")
            createCategories()
        } else {
            self.categories = categories
            self.tableView.reloadData()
        }
    }
    
    private func registerCustomCells() {
        let nib = UINib(nibName: self.categoryCellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.categoryCellIdentifier)
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

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.categoryCellIdentifier) as? CategoryTableViewCell else
        {
            return UITableViewCell()
        }
        if let category = self.categories?[indexPath.row] {
            cell.setupCell(category: category)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newsViewController = storyboard?.instantiateViewController(identifier: "NewsViewController") as? NewsViewController, let category = self.categories?[indexPath.row] {
            newsViewController.category = category
            navigationController?.pushViewController(newsViewController, animated: true)
        }
    }
}
