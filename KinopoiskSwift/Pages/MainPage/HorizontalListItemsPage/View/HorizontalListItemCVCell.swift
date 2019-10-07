//
//  HorizontalListItemCVCell.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/25/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class HorizontalListItemCVCell: UICollectionViewCell, ReusableView {
    
    private static let loadingTitle = "Loading title"
    
    private let containerView = UIView()
    private let verticalStackView = UIStackView()
    private let imageView = CachedImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    func set(model: TmdbModel) {
        imageView.loadImage(urlString: model.getPosterPathUrlString())
        titleLabel.text = model.getTitle()
        subtitleLabel.text = model.getSubtitle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hideLoadingState() {
        verticalStackView.hideSkeleton()
    }
    
    func showLoadingState() {
        verticalStackView.showAnimatedSkeleton()
    }
}

extension HorizontalListItemCVCell: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleLabel)
    }
    
    func setViewConstraints() {
        verticalStackView.anchor(
            top: topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            topConstant: 4,
            leftConstant: 4,
            rightConstant: 4
        )
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3/2).isActive = true
    }
    
    func stylizeViews() {
        verticalStackView.distribution = .fill
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 6
        
        imageView.isSkeletonable = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        titleLabel.text = HorizontalListItemCVCell.loadingTitle
        titleLabel.isSkeletonable = true
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .black
        titleLabel.font =  UIFont.systemFont(ofSize: 12, weight: .medium)
        
        subtitleLabel.text = HorizontalListItemCVCell.loadingTitle
        subtitleLabel.isSkeletonable = true
        subtitleLabel.textColor = .gray
        subtitleLabel.font = UIFont.systemFont(ofSize: 10)
    }
}
