//
//  AddNumberViewController.swift
//  Tarea2
//
//  Created by admin on 3/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol AddNumberViewControllerDelegate: class {
    func addNumber(number: Number)
}

class AddNumberViewController: UIViewController {
    
    weak var delegate: AddNumberViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNumberAction(_ sender: Any) {
        for n in 1 ... 100 {
            let pair = n % 2
            var isPair = false
            if pair == 0 {
                isPair = true
            }
            let number = Number(number: n, isPair: isPair)
            delegate?.addNumber(number: number)
        }
        closeAction(self)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func endEditingAction(_ sender: Any) {
        view.endEditing(true)
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
