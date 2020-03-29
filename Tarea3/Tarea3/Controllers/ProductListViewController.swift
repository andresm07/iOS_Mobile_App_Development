//
//  ProductListViewController.swift
//  Tarea3
//
//  Created by admin on 3/22/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let productCellIdentifier = "ProductTableViewCell"
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        registerCustomCells()
        addProductNavigationButton()
        //loadTestProducts()
        //productListSorter()
        
    }
    
    private func productListSorter() {
        //self.products.sorted(by: {$0.date > $1.date})
        self.products.reverse()
        self.tableView.reloadData()
    }
    
    private func loadTestProducts() {
        self.products.append(Product(name:"Product1", quantity:"12", imageName:"Product1"))
        self.products.append(Product(name:"Product2", quantity:"12", imageName:"Product2"))
        self.products.append(Product(name:"Product3", quantity:"12", imageName:"Product3"))
        self.products.append(Product(name:"Product4", quantity:"12", imageName:"Product4"))
        self.products.append(Product(name:"Product5", quantity:"12", imageName:"Product5"))
    }
    
    private func registerCustomCells() {
        let nib = UINib(nibName: self.productCellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.productCellIdentifier)
    }
    
    public func addProductNavigationButton() {
        let addProductNavigationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProductAction(sender:)))
        navigationItem.rightBarButtonItem = addProductNavigationButton
    }
    
    @objc func addProductAction(sender: UIBarButtonItem) {
        if let addProductTableViewController = storyboard?.instantiateViewController(identifier: "AddProductTableViewController") as? AddProductTableViewController {
            addProductTableViewController.delegate = self
            navigationController?.pushViewController(addProductTableViewController, animated: true)
        }
    }
    
}

extension ProductListViewController: AddProductTableViewControllerProtocol {
    func addProduct(product: Product) {
        self.products.insert(product, at: 0)
        navigationController?.popViewController(animated: true)
        //self.products.reverse()
        self.tableView.reloadData()
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.productCellIdentifier) as? ProductTableViewCell else
        {
            return UITableViewCell()
        }
        cell.setupCell(product: self.products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let addProductTableViewController = storyboard?.instantiateViewController(identifier: "AddProductTableViewController") as? AddProductTableViewController {
            addProductTableViewController.product = self.products[indexPath.row]
            navigationController?.pushViewController(addProductTableViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.products.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
        }
    }
}
