//
//  CarModelTableViewCell.swift
//  TableViewWithCustomHeaders
//
//  Created by admin on 4/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CarModelTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var engineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupCell(carModel: CarModel) {
        self.nameLabel.text = "Model: " + carModel.name
        self.yearLabel.text = "Fabrication Year: \(carModel.year)"
        switch carModel.engine {
        case .electric:
            self.engineLabel.text = "Electric Engine"
        case .diesel:
            self.engineLabel.text = "Diesel Engine"
        default:
            self.engineLabel.text = "Gasoline Engine"
        }
    }
    
}
