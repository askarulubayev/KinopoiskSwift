//
//  ImageProtocol.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

protocol ImageProtocol {
    var rawValue: String { get }
}

extension ImageProtocol {
    
    var uiImage: UIImage? {
        return UIImage(named: rawValue)
    }
    
    var cgImage: CGImage? {
        return self.uiImage?.cgImage
    }
}
