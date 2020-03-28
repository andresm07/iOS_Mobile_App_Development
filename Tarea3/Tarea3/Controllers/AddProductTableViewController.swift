//
//  AddProductTableViewController.swift
//  Tarea3
//
//  Created by admin on 3/22/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol AddProductTableViewControllerProtocol: class {
    func addProduct(product: Product)
}

class AddProductTableViewController: UITableViewController {
    
    var product: Product?
    weak var delegate: AddProductTableViewControllerProtocol?
    
    
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var productQuantityTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var productIconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let product = self.product {
            self.productNameTextField.text = product.name
            self.productNameTextField.isUserInteractionEnabled = false
            self.productQuantityTextField.text = String(product.quantity)
            self.productQuantityTextField.isUserInteractionEnabled = false
            self.dateLabel.text = product.date.getFormattedDate(dateStyle: .short, timeStyle: .short)
            self.productIconImageView.image = UIImage(named: product.imageName)
        } else {
            saveProductNavigationButton()
        }
        
    }
    
    func saveProductNavigationButton() {
        let saveProductNavigationButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveProductAction(sender:)))
        navigationItem.rightBarButtonItem = saveProductNavigationButton
    }
    
    @objc func saveProductAction(sender: UIBarButtonItem) {
        if let productName = self.productNameTextField.text, productName.count > 0, self.productQuantityTextField.text!.count > 0 {
            let randomImageChooser = Int.random(in: 1 ... 5)
            var randomImageName = ""
            switch randomImageChooser {
            case 1:
                randomImageName = "Product1"
            case 2:
                randomImageName = "Product2"
            case 3:
                randomImageName = "Product3"
            case 4:
                randomImageName = "Product4"
            case 5:
                randomImageName = "Product5"
            default:
                randomImageName = ""
            }
            let product = Product(name: productName, quantity: self.productQuantityTextField!.text!, imageName: randomImageName)
            delegate?.addProduct(product: product)
        } else {
            let alertController = UIAlertController(title: "Error", message: "Debe llenar los datos", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
