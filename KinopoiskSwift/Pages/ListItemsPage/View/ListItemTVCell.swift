//
//  ListItemTVCell.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class ListItemTVCell: UITableViewCell, ReusableView {
    
    private let cardBackgroundView = UIView()
    private let itemImageView = CachedImageView()
    private let verticalStackView = UIStackView()
    private let itemTitleLabel = UILabel()
    private let itemSubtitleLabel = UILabel()
    private let itemVoteAverageLabel = UILabel()
    private let itemGenresLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
        itemTitleLabel.text = nil
        itemSubtitleLabel.text = nil
        itemVoteAverageLabel.text = nil
        itemGenresLabel.text = nil
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

extension ListItemTVCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        cardBackgroundView.setupDefaultClickAnimation(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        cardBackgroundView.setupDefaultClickAnimation(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        cardBackgroundView.setupDefaultClickAnimation(isHighlighted: false)
    }
}


extension ListItemTVCell: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(cardBackgroundView)
        cardBackgroundView.addSubview(itemImageView)
        cardBackgroundView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(itemTitleLabel)
        verticalStackView.addArrangedSubview(SpacerView(space: 1))
        verticalStackView.addArrangedSubview(itemSubtitleLabel)
        verticalStackView.addArrangedSubview(itemVoteAverageLabel)
        verticalStackView.addArrangedSubview(SpacerView(space: 2))
        verticalStackView.addArrangedSubview(itemGenresLabel)
    }
    
    func setViewConstraints() {
        cardBackgroundView.anchor(
            top: topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            bottom: bottomAnchor,
            topConstant: 4,
            leftConstant: 8,
            rightConstant: 8,
            bottomConstant: 4
        )
        
        itemImageView.anchor(
            top: cardBackgroundView.topAnchor,
            left: cardBackgroundView.leftAnchor,
            bottom: cardBackgroundView.bottomAnchor,
            topConstant: 4,
            leftConstant: 4,
            bottomConstant: 4,
            widthConstant: 60,
            heightConstant: 90
        )
        
        verticalStackView.anchorCenterYToSuperview()
        verticalStackView.anchor(
            left: itemImageView.rightAnchor,
            right: cardBackgroundView.rightAnchor,
            leftConstant: 16,
            rightConstant: 16
        )
    }
    
    func stylizeViews() {
        backgroundColor = AppColor.whitish.uiColor
        selectionStyle = .none
        
        cardBackgroundView.backgroundColor = .white
        
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
