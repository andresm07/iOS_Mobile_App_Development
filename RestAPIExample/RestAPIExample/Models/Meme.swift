//
//  Meme.swift
//  RestAPIExample
//
//  Created by admin on 4/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct MemeKeys {
    static let id = "ID"
    static let bottomText = "bottomText"
    static let image = "image"
    static let name = "name"
    static let rank = "rank"
    static let tags = "tags"
    static let topText = "topText"
}

struct Meme {
    var id: Int
    var bottomText: String
    var image: String
    var name: String
    var rank: Int
    var tags: [String]
    var topText: String
}

extension Meme {
    init(dictionary: [String: Any]) {
        self.id = dictionary[MemeKeys.id] as? Int ?? -1
        self.bottomText = dictionary[MemeKeys.bottomText] as? String ?? ""
        self.image = dictionary[MemeKeys.image] as? String ?? ""
        self.name = dictionary[MemeKeys.name] as? String ?? ""
        self.rank = dictionary[MemeKeys.rank] as? Int ?? -1
        self.tags = (dictionary[MemeKeys.tags] as? String ?? "").components(separatedBy: ",")
        self.topText = dictionary[MemeKeys.topText] as? String ?? ""
    }
}

