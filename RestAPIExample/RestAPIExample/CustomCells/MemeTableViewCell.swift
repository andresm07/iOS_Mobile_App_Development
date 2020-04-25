//
//  MemeTableViewCell.swift
//  RestAPIExample
//
//  Created by admin on 4/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Kingfisher

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeTopTextLabel: UILabel!
    @IBOutlet weak var memeBottomTextLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setupCell(meme: Meme) {
        if let imageUrl = URL(string: meme.image) {
            self.memeImageView.kf.indicatorType = .activity
            let processor = DownsamplingImageProcessor(size: self.memeImageView.frame.size)
            let placeHolderImage = R.image.defaultImage()
            self.memeImageView.kf.setImage(with: imageUrl, placeholder: placeHolderImage, options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(1)), .cacheOriginalImage])
        }
        self.memeTopTextLabel.text = meme.topText
        self.memeBottomTextLabel.text = meme.bottomText
    }
    
}
