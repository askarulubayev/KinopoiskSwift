//
//  DateFormat.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/10/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

public enum DateFormat {
    case ddMMyyyy(separator: String)
    case yyyyMMdd(separator: String)
    
    var string: String {
        switch self {
        case .ddMMyyyy(let seperator):
            return ["dd", "MM", "yyyy"].joined(separator: seperator)
        case .yyyyMMdd(let separator):
            return ["yyyy", "MM", "dd"].joined(separator: separator)
        }
    }
}
