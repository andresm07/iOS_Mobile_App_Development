//
//  CategoryTableViewCell.swift
//  Clase4
//
//  Created by admin on 3/20/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupCell(category: Category) {
        self.titleLabel.text = category.name
        self.categoryImageView.image = UIImage(named: category.imageName)
    }
    
}
