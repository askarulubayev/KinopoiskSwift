//
//  ItemDetailsOverviewTVCell.swift
//  KinopoiskSwift
//
//  Created by Аскар on 7/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class ItemDetailsOverviewTVCell: UITableViewCell, ReusableView {
    
    private let overviewLabel = UILabel()
    private let separatorView = UIView()
    
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

extension ItemDetailsOverviewTVCell: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(overviewLabel)
        addSubview(separatorView)
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
        
        separatorView.anchor(left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, heightConstant: 0.3)
    }
    
    func stylizeViews() {
        overviewLabel.textColor = .black
        overviewLabel.font = UIFont.systemFont(ofSize: 14)
        overviewLabel.numberOfLines = 6
        
        separatorView.backgroundColor = AppColor.lightGray.uiColor
    }
}
