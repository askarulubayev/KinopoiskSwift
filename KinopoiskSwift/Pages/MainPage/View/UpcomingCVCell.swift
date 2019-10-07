//
//  UpcomingCVCell.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class UpcomingMovieCVCell: UICollectionViewCell, ReusableView {
    
    private let containerView = UIView()
    private let posterImageView = CachedImageView()
    private let backdropImageView = CachedImageView()
    private let darkCoverView = UIView()
    private let verticalStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: Movie) {
        posterImageView.loadImage(urlString: movie.getPosterPathUrlString())
        backdropImageView.loadImage(urlString: movie.getBackdropPathUrlString())
        titleLabel.text = movie.getTitle()
        subtitleLabel.text = movie.getOriginalNameWithReleaseDate()
    }
    
    func showLoadingState() {
        darkCoverView.isHidden = true
        containerView.showAnimatedSkeleton()
    }
    
    func hideLoadingState() {
        darkCoverView.isHidden = false
        containerView.hideSkeleton()
    }
}

extension UpcomingMovieCVCell: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(posterImageView)
        containerView.addSubview(backdropImageView)
        containerView.addSubview(darkCoverView)
        containerView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleLabel)
    }
    
    func setViewConstraints() {
        posterImageView.anchor(
            top: topAnchor,
            left: leftAnchor,
            topConstant: 8,
            leftConstant: 16,
            widthConstant: getPosterImageViewWidth(),
            heightConstant: imageViewHeight()
        )
        
        darkCoverView.anchor(
            top: backdropImageView.topAnchor,
            left: backdropImageView.leftAnchor,
            right: backdropImageView.rightAnchor,
            bottom: backdropImageView.bottomAnchor
        )
        
        backdropImageView.anchor(
            top: topAnchor,
            right: rightAnchor,
            topConstant: 8,
            rightConstant: 16,
            widthConstant: getBackdropImageViewWidth(),
            heightConstant: imageViewHeight()
        )
        
        verticalStackView.anchor(
            left: backdropImageView.leftAnchor,
            right: backdropImageView.rightAnchor,
            bottom: backdropImageView.bottomAnchor,
            leftConstant: 4,
            rightConstant: 4,
            bottomConstant: 4
        )
    }
    
    func stylizeViews() {
        posterImageView.isSkeletonable = true
        posterImageView.backgroundColor = .lightGray
        
        backdropImageView.backgroundColor = .lightGray
        backdropImageView.isSkeletonable = true
        
        darkCoverView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 1
        
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor = .white
        
        subtitleLabel.font = UIFont.systemFont(ofSize: 9, weight: .thin)
        subtitleLabel.textColor = .white
    }
}

extension UpcomingMovieCVCell {
    static func getHeight() -> CGFloat {
        return (screenSize.width - 40) * 9 / 22 + 16
    }
    
    private func getPosterImageViewWidth() -> CGFloat {
        return (screenSize.width - 40) * 6 / 22
    }
    
    private func getBackdropImageViewWidth() -> CGFloat {
        return (screenSize.width - 40) * 16 / 22
    }
    
    private func imageViewHeight() -> CGFloat {
        return (screenSize.width - 40) * 9 / 22
    }
}
