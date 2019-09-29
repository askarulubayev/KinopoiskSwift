//
//  Date+Extensions.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/10/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

extension Date {
    static var dayMonthYearDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM YYYY"
        dateFormatter.locale = Locale(identifier: "ru")
        return dateFormatter
    }
    
    func string(withFormat dateFormat: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.string
        return dateFormatter.string(from: self)
    }
}
