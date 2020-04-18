//
//  MemeViewController.swift
//  RestAPIExample
//
//  Created by admin on 4/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MemeViewController: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var tableView: UITableView!
    
    let memeTableViewCellIdentifier = "MemeTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        registerCustomCells()
        startAnimating()
        APIManager.getAllMemes { (error, memes) in
            self.stopAnimating()
            if let meme = memes?.first {
                print(meme.image)
            }
        }
    }
    
    private func registerCustomCells() {
        self.tableView.register(UINib(resource: R.nib.memeTableViewCell), forCellReuseIdentifier: R.nib.memeTableViewCell.name)
    }

}

extension MemeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: self.memeTableViewCellIdentifier) as? MemeTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250.0
    }
}
