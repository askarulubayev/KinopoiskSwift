//
//  SectionHeaderView.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView, ReusableView {
    
    private let titleLabel = UILabel()
    private let rightButton = UIButton()
    private let bottomSeparatorView = UIView()
    
    var performOnRightButtonTap: (() -> Void)?
    
    func set(title: String) {
        titleLabel.text = title
    }
    
    func setRightButton(iconImage: UIImage, rightButtonTapAction: @escaping () -> Void) {
        rightButton.setImage(iconImage, for: .normal)
        performOnRightButtonTap = rightButtonTapAction
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        rightButton.setImage(nil, for: .normal)
        performOnRightButtonTap = nil
    }
    
    @objc private func rightButtonAction() {
        performOnRightButtonTap?()
    }
}

extension SectionHeaderView: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(rightButton)
        addSubview(bottomSeparatorView)
    }
    
    func setViewConstraints() {
        var layoutConstraints = [NSLayoutConstraint]()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ]
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            rightButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            rightButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
        
        bottomSeparatorView.anchor(left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, heightConstant: 0.3)
    }
    
    func stylizeViews() {
        contentView.backgroundColor = AppColor.whitish.uiColor
        
        titleLabel.textColor = AppColor.darkGray.uiColor
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        
        rightButton.contentMode = .scaleAspectFit
        rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
    }
}
