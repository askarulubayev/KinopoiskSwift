//
//  ItemDetailHeaderView.swift
//  KinopoiskSwift
//
//  Created by Аскар on 7/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class ItemDetailHeaderView: UIView {
    
    private let itemImageView = CachedImageView()
    private let verticalStackView = UIStackView()
    private let itemTitleLabel = UILabel()
    private let itemSubtitleLabel = UILabel()
    private let itemVoteAverageLabel = UILabel()
    private let itemGenresLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(model: TmdbModel) {
        itemImageView.loadImage(urlString: model.getPosterPathUrlString())
        itemTitleLabel.text = model.getTitle()
        itemSubtitleLabel.text = model.getSubtitle()
        if let movieTVShowModel = model as? TmdbMovieTVShowModel {
            itemVoteAverageLabel.attributedText = movieTVShowModel.getVoteAverageWithPopularity()
            if let movieModel = movieTVShowModel as? Movie {
                itemGenresLabel.text = MovieGenresStore.shared.getGenres(ids: movieModel.genre_ids ?? [])?.joined(separator: ", ")
            } else if let tvModel = movieTVShowModel as? TVShow {
                itemGenresLabel.text = TVGenreStore.shared.getGenres(ids: tvModel.genre_ids ?? [])?.joined(separator: ", ")
            }
        }
    }
}

extension ItemDetailHeaderView: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(itemImageView)
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(itemTitleLabel)
        verticalStackView.addArrangedSubview(SpacerView(space: 1))
        verticalStackView.addArrangedSubview(itemSubtitleLabel)
        verticalStackView.addArrangedSubview(itemVoteAverageLabel)
        verticalStackView.addArrangedSubview(SpacerView(space: 2))
        verticalStackView.addArrangedSubview(itemGenresLabel)
    }
    
    func setViewConstraints() {
        itemImageView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            topConstant: 4,
            leftConstant: 4,
            bottomConstant: 4,
            widthConstant: 60,
            heightConstant: 90
        )
        
        verticalStackView.anchorCenterYToSuperview()
        verticalStackView.anchor(
            left: itemImageView.rightAnchor,
            right: rightAnchor,
            leftConstant: 12,
            rightConstant: 12
        )
    }
    
    func stylizeViews() {
        backgroundColor = AppColor.lightGray.uiColor
        
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        
        verticalStackView.distribution = .fill
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.spacing = 3
        
        itemTitleLabel.textColor = .black
        itemTitleLabel.font =  UIFont.boldSystemFont(ofSize: 14)
        
        itemSubtitleLabel.textColor = .black
        itemSubtitleLabel.font = UIFont.systemFont(ofSize: 12)
        
        itemGenresLabel.textColor = .darkGray
        itemGenresLabel.font = UIFont.systemFont(ofSize: 12)
    }
}
