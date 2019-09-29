//
//  OverviewTVCell.swift
//  KinopoiskSwift
//
//  Created by Аскар on 9/28/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class OverviewTVCell: UITableViewCell, ReusableView {
    
    private let overviewLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        overviewLabel.text = nil
    }
    
    func set(overview: String?) {
        overviewLabel.text = overview
    }
}

extension OverviewTVCell: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(overviewLabel)
    }
    
    func setViewConstraints() {
        overviewLabel.anchor(
            top: topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            bottom: bottomAnchor,
            topConstant: 12,
            leftConstant: 16,
            rightConstant: 16,
            bottomConstant: 12
        )
    }
    
    func stylizeViews() {
        selectionStyle = .none
        
        overviewLabel.textColor = .black
        overviewLabel.font = UIFont.systemFont(ofSize: 14)
        overviewLabel.numberOfLines = 0
    }
}
