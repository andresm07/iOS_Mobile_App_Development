//
//  ProductListViewController.swift
//  Tarea3
//
//  Created by admin on 3/22/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RealmSwift

class ProductListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let productCellIdentifier = "ProductTableViewCell"
    let realmManager = RealmManager()
    var products: Results<Product>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        registerCustomCells()
        addProductNavigationButton()
        //loadTestProducts()
    }
    
//    private func loadTestProducts() {
//        self.products.append(Product(name:"Bread", quantity:"12", imageName:"Product5"))
//    }
    
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
        /*FALTA*/
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.productCellIdentifier) as? ProductTableViewCell else
        {
            return UITableViewCell()
        }
        if let product = self.products?[indexPath.row] {
            cell.setupCell(product: product)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let addProductTableViewController = storyboard?.instantiateViewController(identifier: "AddProductTableViewController") as? AddProductTableViewController, let product = self.products?[indexPath.row] {
            addProductTableViewController.product = product
            navigationController?.pushViewController(addProductTableViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            /*FALTA*/
            //self.products.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
        }
    }
}
