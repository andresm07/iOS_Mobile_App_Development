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
    let realmManager = RealmManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        registerCustomCells()
        addNewsNavigationButton()
    }
    
    private func registerCustomCells() {
        let nib = UINib(nibName: self.newsCellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.newsCellIdentifier)
    }
    
    func addNewsNavigationButton() {
        let addNewsNavigationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewsAction(sender:)))
        navigationItem.rightBarButtonItem = addNewsNavigationButton
    }
    
    @objc func addNewsAction(sender: UIBarButtonItem) {
        if let addNewsViewController = storyboard?.instantiateViewController(identifier: "AddNewsViewController") as? AddNewsViewController {
            addNewsViewController.delegate = self
            navigationController?.pushViewController(addNewsViewController, animated: true)
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

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.category?.news.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.newsCellIdentifier) as? NewsTableViewCell else
        {
            return UITableViewCell()
        }
        if let news = self.category?.news[indexPath.row] {
            cell.setupCell(news: news)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let addNewsViewController = storyboard?.instantiateViewController(identifier: "AddNewsViewController") as? AddNewsViewController {
            addNewsViewController.news = self.category?.news[indexPath.row]
            navigationController?.pushViewController(addNewsViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let news = category?.news[indexPath.row] {
                self.realmManager.deleteNews(news: news)
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.endUpdates()
            }
        }
    }
}

extension NewsViewController: AddNewsViewControllerProtocol {
    func addNews(news: News) {
        if let category = self.category {
            self.realmManager.addNewsToCategory(news: news, category: category)
            navigationController?.popViewController(animated: true)
            self.tableView.reloadData()
        }
    }
}
