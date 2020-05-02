//
//  NewsTableViewCell.swift
//  CleanSwiftExample
//
//  Created by admin on 5/2/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(news: News.DataSource.ViewModel.DisplayedNews) {
        self.newsTitleLabel.text = news.title
        self.newsDateLabel.text = news.date
    }
    
}
