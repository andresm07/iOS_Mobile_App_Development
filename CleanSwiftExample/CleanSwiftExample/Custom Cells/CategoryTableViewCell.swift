//
//  CategoryTableViewCell.swift
//  CleanSwiftExample
//
//  Created by admin on 5/2/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(category: Categories.DataSource.ViewModel.DisplayedCategory) {
        self.categoryNameLabel.text = category.title
        self.categoryImageView.image = category.image
    }
    
}
