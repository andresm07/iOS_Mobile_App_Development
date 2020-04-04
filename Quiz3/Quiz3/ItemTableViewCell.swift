//
//  ItemTableViewCell.swift
//  Quiz3
//
//  Created by admin on 4/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupCell(item: Item) {
        self.nameLabel.text = item.name
        self.dateLabel.text = "Purchase Date: " + item.purchaseDate.getFormattedDate(dateStyle: .short, timeStyle: .short)
        self.quantityLabel.text = "Quantity: " + String(item.quantity)
    }
    
}
