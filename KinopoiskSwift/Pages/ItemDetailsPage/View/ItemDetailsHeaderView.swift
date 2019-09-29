//
//  ItemDetailsHeaderView.swift
//  KinopoiskSwift
//
//  Created by Аскар on 7/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class ItemDetailsHeaderView: UIView {
    
    private let itemImageView = CachedImageView()
    private let verticalStackView = UIStackView()
    private let itemTitleLabel = UILabel()
    private let itemSubtitleLabel = UILabel()
    private let itemGenresLabel = UILabel()
    private let itemDescriptionLabel = UILabel()
    private let separatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(model: TmdbDetailsModel) {
        itemImageView.loadImage(urlString: model.getPosterPathUrlString())
        itemTitleLabel.text = model.getTitle()
        itemSubtitleLabel.text = model.getSubtitle()
        itemGenresLabel.text = model.getGenres()
        itemDescriptionLabel.text = model.getDescription()
    }
}

extension ItemDetailsHeaderView: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(itemImageView)
        addSubview(verticalStackView)
        addSubview(separatorView)
        verticalStackView.addArrangedSubview(itemTitleLabel)
        verticalStackView.addArrangedSubview(itemSubtitleLabel)
        verticalStackView.addArrangedSubview(SpacerView(space: 4))
        verticalStackView.addArrangedSubview(itemGenresLabel)
        verticalStackView.addArrangedSubview(itemDescriptionLabel)
        verticalStackView.addArrangedSubview(UIView())
    }
    
    func setViewConstraints() {
        itemImageView.anchor(
            top: topAnchor,
            left: leftAnchor,
            topConstant: 16,
            leftConstant: 16,
            widthConstant: 100,
            heightConstant: 150
        )
        
        verticalStackView.anchor(
            top: itemImageView.topAnchor,
            left: itemImageView.rightAnchor,
            right: rightAnchor,
            bottom: itemImageView.bottomAnchor,
            leftConstant: 16,
            rightConstant: 16,
            bottomConstant: -4
        )
        
        separatorView.anchor(left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, heightConstant: 0.3)
    }
    
    func stylizeViews() {
        backgroundColor = .white
        
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        
        verticalStackView.distribution = .fill
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        
        itemTitleLabel.textColor = .black
        itemTitleLabel.font =  UIFont.boldSystemFont(ofSize: 14)
        
        itemSubtitleLabel.textColor = .black
        itemSubtitleLabel.font = UIFont.systemFont(ofSize: 12)
        
        itemGenresLabel.textColor = .gray
        itemGenresLabel.font = UIFont.systemFont(ofSize: 12)
        itemGenresLabel.numberOfLines = 2
        
        itemDescriptionLabel.textColor = .darkGray
        itemDescriptionLabel.font = UIFont.systemFont(ofSize: 12)
        itemDescriptionLabel.numberOfLines = 0
        
        separatorView.backgroundColor = AppColor.lightGray.uiColor
    }
}
