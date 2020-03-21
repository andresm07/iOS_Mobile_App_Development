//
//  NewsViewController.swift
//  Clase4
//
//  Created by admin on 3/20/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var category: Category?
    
    let newsCellIdentifier = "NewsTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        registerCustomCells()
    }
    
    private func registerCustomCells() {
        let nib = UINib(nibName: self.newsCellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.newsCellIdentifier)
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

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.newsCellIdentifier) as? NewsTableViewCell else
        {
            return UITableViewCell()
        }
        cell.titleLabel.text = "Title Label Test"
        cell.dateLabel.text = "Date Label Test"
        return cell
    }
    
}
