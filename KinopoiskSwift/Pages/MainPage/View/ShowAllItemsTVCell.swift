//
//  ShowAllItemsTVCell.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/25/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class ShowAllItemsTVCell: UITableViewCell, ReusableView {
    
    private static let textForSkeeleton = "Ошибка при загрузке"
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let allLabel = UILabel()
    private let arrowRightImageView = UIImageView()
    private let separatorView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String?) {
        titleLabel.text = title
    }
    
    func makeBigTitle() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 19)
    }
    
    func makeSmallTitle() {
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    func showSeparatorView() {
        separatorView.isHidden = false
    }
    
    func hideSeparatorView() {
        separatorView.isHidden = true
    }
    
    func showLoadingState() {
        titleLabel.text = ShowAllItemsTVCell.textForSkeeleton
        containerView.showAnimatedSkeleton()
    }
    
    func hideLoadingState() {
        if titleLabel.text == ShowAllItemsTVCell.textForSkeeleton {
            titleLabel.text = nil
        }
        containerView.hideSkeleton()
    }
}

extension ShowAllItemsTVCell: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(allLabel)
        containerView.addSubview(arrowRightImageView)
        containerView.addSubview(separatorView)
    }
    
    func setViewConstraints() {
        var layoutConstraints = [NSLayoutConstraint]()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
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
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    func stylizeViews() {
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.isSkeletonable = true
        titleLabel.linesCornerRadius = 2
        
        allLabel.isHidden = true
        allLabel.text = "Все"
        allLabel.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        allLabel.textColor = .gray
        
        arrowRightImageView.image = AppImage.arrowRight.uiImage
        arrowRightImageView.contentMode = .scaleAspectFit
        
        separatorView.backgroundColor = AppColor.lightGray.uiColor
    }
}
