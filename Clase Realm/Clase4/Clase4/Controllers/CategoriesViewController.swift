//
//  CategoriesViewController.swift
//  Clase4
//
//  Created by admin on 3/20/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var categories = [Category]()
    
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
        self.categories.append(Category(name: "Economy", imageName: "Economy", news: [News]()))
        self.categories.append(Category(name: "Incidents", imageName: "Incident", news: [News]()))
        self.categories.append(Category(name: "Sports", imageName: "Sports", news: [News]()))
        self.categories.append(Category(name: "Technology", imageName: "Technology", news: [News]()))
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
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.categoryCellIdentifier) as? CategoryTableViewCell else
        {
            return UITableViewCell()
        }
        cell.setupCell(category: self.categories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newsViewController = storyboard?.instantiateViewController(identifier: "NewsViewController") as? NewsViewController {
            newsViewController.category = self.categories[indexPath.row]
            navigationController?.pushViewController(newsViewController, animated: true)
        }
    }
}
