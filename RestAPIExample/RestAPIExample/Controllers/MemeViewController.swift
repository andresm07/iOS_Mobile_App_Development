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
    
    var memesList = [Meme]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let memeTableViewCellIdentifier = "MemeTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        registerCustomCells()
        startAnimating()
        getAllMemes()
    }
    
    private func registerCustomCells() {
        self.tableView.register(UINib(resource: R.nib.memeTableViewCell), forCellReuseIdentifier: R.nib.memeTableViewCell.name)
    }
    
    private func getAllMemes() {
        APIManager.getAllMemes { (error, memes) in
            self.stopAnimating()
            if let error = error {
                self.handleError(error: error)
            }
            if let memes = memes {
                self.memesList = memes
            }
        }
    }
    
    private func handleError(error: MemeAPIErrors) {
        var message = ""
        switch error {
        case .invalidURL, .serverError, .wrongAnswer:
            message = "Server issues, please try again later"
        case .noInternetConnection:
            message = "Please check internet connection"
        }
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}

extension MemeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: self.memeTableViewCellIdentifier) as? MemeTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(meme: self.memesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250.0
    }
}
