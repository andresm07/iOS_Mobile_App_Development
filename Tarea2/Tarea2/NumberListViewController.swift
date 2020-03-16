//
//  NumberListViewController.swift
//  Tarea2
//
//  Created by admin on 3/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class NumberListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var numberList = [Number]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    @IBAction func addNumberAction(_ sender: Any) {
        if let addNumberViewController =  self.storyboard?.instantiateViewController(identifier: "AddNumberViewController") as? AddNumberViewController {
            addNumberViewController.modalPresentationStyle = .fullScreen
            addNumberViewController.delegate = self
            self.present(addNumberViewController, animated: true, completion: nil)
        }
        
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

extension NumberListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NumberCell") else
        {
            return UITableViewCell()
        }
        let number = numberList[indexPath.row]
        cell.textLabel?.text = "Value: \(number.number)"
        if number.isPair {
            cell.backgroundColor = UIColor.systemRed
        }
        else {
            cell.backgroundColor = UIColor.systemBlue
        }
        return cell
    }
}

extension NumberListViewController: AddNumberViewControllerDelegate {
    func addNumber(number: Number) {
        numberList.append(number)
        tableView.reloadData()
    }
}
