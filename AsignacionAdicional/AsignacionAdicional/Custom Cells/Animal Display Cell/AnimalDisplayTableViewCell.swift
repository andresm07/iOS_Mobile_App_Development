//
//  AnimalDisplayTableViewCell.swift
//  AsignacionAdicional
//
//  Created by admin on 3/28/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class AnimalDisplayTableViewCell: UITableViewCell {

    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupCell(owner: Owner, animal: Animal) {
        self.animalImageView.image = UIImage(named: animal.imageName)
        self.phoneNumberLabel.text = owner.phoneNumber
    }
}
