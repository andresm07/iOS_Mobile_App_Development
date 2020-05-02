//
//  Date+Formatter.swift
//  CleanSwiftExample
//
//  Created by admin on 5/2/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension Date{
    func getFormattedDate(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        let localizedDate = formatter.string(from: self)
        return localizedDate
    }
}
