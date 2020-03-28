//
//  ViewController.swift
//  Quiz2
//
//  Created by admin on 3/28/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let multiplicationCellIdentifier = "MultiplicationTableViewCell"
    var multiplications = [Multiplication]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        registerCustomCells()
    }
    
    private func registerCustomCells() {
        let nib = UINib(nibName: self.multiplicationCellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.multiplicationCellIdentifier)
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 101
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.multiplicationCellIdentifier) as? MultiplicationTableViewCell else
        {
            return UITableViewCell()
        }
        let myMultiplication = Multiplication(mainMultiplication: "\(8*indexPath.row)", multiplicationValue: indexPath.row)
        cell.setupCell(myMultiplication: myMultiplication)
        return cell
    }
    
}

