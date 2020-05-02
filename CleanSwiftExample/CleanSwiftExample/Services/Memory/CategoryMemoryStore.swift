//
//  CategoryMemoryStore.swift
//  CleanSwiftExample
//
//  Created by admin on 4/25/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class CategoryMemoryStore: CategoryStoreProtocol {
    
    func insert(category: NativeCategory, completionHandler: () -> Void) {
        completionHandler()
    }
    
    func fetchAll(completionHandler: ([NativeCategory]) -> Void) {
        let categories = [NativeCategory(name: "Test1", imageName: "Test1", news: [NativeNews]()),
                          NativeCategory(name: "Test2", imageName: "Test2", news: [NativeNews]()),
                          NativeCategory(name: "Test3", imageName: "Test3", news: [NativeNews]()),
                          NativeCategory(name: "Test4", imageName: "Test4", news: [NativeNews]()),
                          NativeCategory(name: "Test5", imageName: "Test5", news: [NativeNews]()),
                          NativeCategory(name: "Test6", imageName: "Test6", news: [NativeNews]()),
                          NativeCategory(name: "Test7", imageName: "Test7", news: [NativeNews]()),
                          NativeCategory(name: "Test8", imageName: "Test8", news: [NativeNews]())]
        completionHandler(categories)
    }
    
    func fetch(id: String, completionHandler: (NativeCategory?) -> Void) {
        
    }
    
}
