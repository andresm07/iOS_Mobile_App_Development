//
//  MultiplicationTableViewCell.swift
//  Quiz2
//
//  Created by admin on 3/28/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class MultiplicationTableViewCell: UITableViewCell {

    @IBOutlet weak var multiplicationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupCell(myMultiplication: Multiplication) {
        self.multiplicationLabel.text = "8 x \(myMultiplication.multiplicationValue) = \(myMultiplication.mainMultiplication)"
    }
    
}
