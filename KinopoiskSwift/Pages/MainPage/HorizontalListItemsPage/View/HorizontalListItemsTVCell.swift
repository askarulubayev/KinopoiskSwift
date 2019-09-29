//
//  HorizontalListItemsTVCell.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/25/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class HorizontalListItemsTVCell: UITableViewCell, ReusableView {
    
    let viewController = HorizontalListItemsViewController(collectionViewLayout: HorizontalCVLayout())
    
    func set(models: [TmdbModel]) {
        viewController.set(models: models)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(viewController.view)
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.anchor(
            top: topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            bottom: bottomAnchor
        )
        viewController.view.heightAnchor.constraint(
            greaterThanOrEqualToConstant: HorizontalListItemsTVCell.getCellHeight()
        ).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func getCellHeight() -> CGFloat {
        return (screenSize.width - 32) * 9 / 22 + 32 + 4 + 28
    }
    
    static func getCellWidth() -> CGFloat {
        return (screenSize.width - 32) * 6 / 22 + 8
    }
}
