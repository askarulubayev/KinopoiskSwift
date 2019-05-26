//
//  AppColor.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit.UIColor

enum AppColor {
    case orange, lightGray, gray, darkGray, lightBlue, brown
    
    var uiColor: UIColor {
        switch self {
        case .orange: return UIColor(rgb: 250, 96, 12)
        case .lightGray: return UIColor(rgb: 227, 227, 221)
        case .gray: return UIColor(rgb: 163, 163, 163)
        case .darkGray: return UIColor(rgb: 91, 87, 83)
        case .lightBlue: return UIColor(rgb: 239, 243, 250)
        case .brown: return UIColor(rgb: 58, 58, 58)
        }
    }
    
    var cgColor: CGColor { return uiColor.cgColor }
}

extension UIColor {
    
    /// Initialize from integral RGB values (+ alpha channel in range 0-100)
    convenience init(rgb: UInt8..., alpha: UInt = 100) {
        self.init(
            red: CGFloat(rgb[0]) / 255,
            green: CGFloat(rgb[1]) / 255,
            blue: CGFloat(rgb[2]) / 255,
            alpha: CGFloat(min(alpha, 100)) / 100
        )
    }
}
