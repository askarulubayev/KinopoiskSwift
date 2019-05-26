//
//  ShowAllItemsTVCell.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/25/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class ShowAllItemsTVCell: UITableViewCell, ReusableView {
    
    private let topSeperatorView = UIView()
    let titleLabel = UILabel()
    let allLabel = UILabel()
    let arrowRightImageView = UIImageView()
    
    func set(title: String?) {
        titleLabel.text = title
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShowAllItemsTVCell: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(topSeperatorView)
        addSubview(titleLabel)
        addSubview(allLabel)
        addSubview(arrowRightImageView)
    }
    
    func setViewConstraints() {
        topSeperatorView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, heightConstant: 0.3)
        
        var layoutConstraints = [NSLayoutConstraint]()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12)
        ]
        
        allLabel.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            allLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            allLabel.rightAnchor.constraint(equalTo: arrowRightImageView.leftAnchor, constant: -6)
        ]
        
        arrowRightImageView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            arrowRightImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowRightImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            arrowRightImageView.widthAnchor.constraint(equalToConstant: 13),
            arrowRightImageView.heightAnchor.constraint(equalToConstant: 13)
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    func stylizeViews() {
        // TODO: uncomment this line after solving problem with seperator lines in main page
        // topSeperatorView.backgroundColor = .lightGray
        
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = .black
        
        allLabel.text = "Все"
        allLabel.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        allLabel.textColor = .gray
        
        arrowRightImageView.image = AppImage.arrowRight.uiImage
        arrowRightImageView.contentMode = .scaleAspectFit
    }
}
