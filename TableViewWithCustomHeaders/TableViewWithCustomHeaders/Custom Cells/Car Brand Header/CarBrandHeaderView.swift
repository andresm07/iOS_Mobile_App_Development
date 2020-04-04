//
//  CarBrandHeaderView.swift
//  TableViewWithCustomHeaders
//
//  Created by admin on 4/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CarBrandHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    public func setupCell(carBrand: CarBrand) {
        self.nameLabel.text = carBrand.name
        self.countryLabel.text = carBrand.country
    }

}
