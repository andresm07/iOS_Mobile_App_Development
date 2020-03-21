//
//  AddNewsViewController.swift
//  Clase4
//
//  Created by admin on 3/21/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol AddNewsViewControllerProtocol: class {
    func addNews(news: News)
}

class AddNewsViewController: UITableViewController {

    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var news: News?
    
    weak var delegate: AddNewsViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let news = self.news {
            titleTextField.text = news.title
            titleTextField.isUserInteractionEnabled = false
            descriptionTextView.text = news.descriptionNews
            descriptionTextView.isEditable = false
        } else {
            saveNewsNavigationButton()
        }
    }
    
    func saveNewsNavigationButton() {
        let saveNewsNavigationButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNewsAction(sender:)))
        navigationItem.rightBarButtonItem = saveNewsNavigationButton
    }
    
    @objc func saveNewsAction(sender: UIBarButtonItem) {
        if let title = titleTextField.text, title.count > 0, descriptionTextView.text.count > 0 {
            let news = News(title: title, descriptionNews: descriptionTextView.text)
            delegate?.addNews(news: news)
        } else {
            let alertController = UIAlertController(title: "Error", message: "Debe llenar los datos", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
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
