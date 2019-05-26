//
//  UpcomingCVCell.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class UpcomingMovieCVCell: UICollectionViewCell, ReusableView {
    
    let posterImageView = CachedImageView()
    let backdropImageView = CachedImageView()
    let darkCoverView = UIView()
    let verticalStackView = UIStackView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    func set(movie: Movie) {
        posterImageView.loadImage(urlString: movie.getPosterPathUrlString())
        backdropImageView.loadImage(urlString: movie.getBackdropPathUrlString())
        titleLabel.text = movie.getTitle()
        subtitleLabel.text = movie.getOriginalNameWithReleaseDate()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UpcomingMovieCVCell: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(posterImageView)
        addSubview(backdropImageView)
        addSubview(darkCoverView)
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleLabel)
    }
    
    func setViewConstraints() {
        posterImageView.anchor(top: topAnchor, left: leftAnchor, topConstant: 8, leftConstant: 12, widthConstant: getPosterImageViewWidth(), heightConstant: imageViewHeight())
        
        darkCoverView.anchor(top: backdropImageView.topAnchor, left: backdropImageView.leftAnchor, right: backdropImageView.rightAnchor, bottom: backdropImageView.bottomAnchor)
        
        backdropImageView.anchor(top: topAnchor, right: rightAnchor, topConstant: 8, rightConstant: 12, widthConstant: getBackdropImageViewWidth(), heightConstant: imageViewHeight())
        
        verticalStackView.anchor(left: backdropImageView.leftAnchor, right: backdropImageView.rightAnchor, bottom: backdropImageView.bottomAnchor, leftConstant: 4, rightConstant: 4, bottomConstant: 4)
    }
    
    func stylizeViews() {
        posterImageView.backgroundColor = .lightGray
        
        backdropImageView.backgroundColor = .lightGray
        
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
        return (screenSize.width - 32) * 9 / 22 + 16
    }
    
    private func getPosterImageViewWidth() -> CGFloat {
        return (screenSize.width - 32) * 6 / 22
    }
    
    private func getBackdropImageViewWidth() -> CGFloat {
        return (screenSize.width - 32) * 16 / 22
    }
    
    private func imageViewHeight() -> CGFloat {
        return (screenSize.width - 32) * 9 / 22
    }
}
