//
//  ReusableView.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        if let nibName = String(describing: self).components(separatedBy: ".").last {
            return nibName
        }
        fatalError("Couldn't get nibName")
    }
    
    static func instantiate() -> Self {
        if let nib = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? Self {
            return nib
        }
        fatalError("Couldn't get nib")
    }
}
