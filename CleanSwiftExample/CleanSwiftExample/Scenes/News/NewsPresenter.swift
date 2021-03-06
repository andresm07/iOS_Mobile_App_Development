//
//  NewsPresenter.swift
//  CleanSwiftExample
//
//  Created by admin on 5/2/20.
//  Copyright (c) 2020 admin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NewsPresentationLogic {
    func presentDataSource(response: News.DataSource.Response)
}

class NewsPresenter: NewsPresentationLogic {
    weak var viewController: NewsDisplayLogic?
    
    // MARK: Do something
    
    func presentDataSource(response: News.DataSource.Response) {
        let news = response.news.map({News.DataSource.ViewModel.DisplayedNews(title: $0.title, date: $0.date.getFormattedDate(dateStyle: .short, timeStyle: .short))})
        self.viewController?.displayDataSource(viewModel: News.DataSource.ViewModel(displayedNews: news))
    }
}
