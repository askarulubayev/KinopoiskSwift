//
//  SpacerTVCell.swift
//  KinopoiskSwift
//
//  Created by Аскар on 9/28/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class SpacerTVCell: UITableViewCell, ReusableView {
    
    private let spacerView = SpacerView(space: 4)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(spacerView)
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        spacerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        spacerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        spacerView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor).isActive = true
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
