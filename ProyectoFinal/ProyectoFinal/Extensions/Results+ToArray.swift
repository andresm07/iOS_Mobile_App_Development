//
//  Results+ToArray.swift
//  ProyectoFinal
//
//  Created by admin on 4/24/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    
    public func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
