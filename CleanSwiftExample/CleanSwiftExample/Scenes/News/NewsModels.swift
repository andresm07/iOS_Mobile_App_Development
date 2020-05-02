//
//  NewsModels.swift
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

enum News {
    // MARK: Use cases
    
    enum DataSource {
        struct Request {
        }
        struct Response {
            var news: [NativeNews]
        }
        struct ViewModel {
            struct DisplayedNews {
                var title: String
                var date: String
            }
            var displayedNews: [DisplayedNews]
        }
    }
}
