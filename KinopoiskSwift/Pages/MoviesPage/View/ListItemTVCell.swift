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
    
    func set(model: TmdbModel) {
        itemTitleLabel.text = model.getTitle()
        itemImageView.loadImage(urlString: model.getPosterPathUrlString())
        itemSubtitleLabel.text = model.getSubtitle()
        if let movieTVShowModel = model as? TmdbMovieTVShowModel {
            itemGenresLabel.text = movieTVShowModel.overview
            itemVoteAverageLabel.attributedText = movieTVShowModel.getVoteAverageWithPopularity()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
    }
}

// MARK: - extension for animation when view tapped
extension ListItemTVCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }
    
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)?=nil) {
        let animationOptions: UIView.AnimationOptions = [.allowUserInteraction]
        if isHighlighted {
            UIView.animate(
                withDuration: 0.8,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0,
                options: animationOptions,
                animations: {
                    self.cardBackgroundView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            })
        } else {
            UIView.animate(
                withDuration: 0.8,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0,
                options: animationOptions,
                animations: {
                    self.cardBackgroundView.backgroundColor = UIColor.white
            })
        }
    }
}


extension ListItemTVCell: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(cardBackgroundView)
        cardBackgroundView.addSubview(itemImageView)
        cardBackgroundView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(itemTitleLabel)
        verticalStackView.addArrangedSubview(SpacerView(space: 3))
        verticalStackView.addArrangedSubview(itemSubtitleLabel)
        verticalStackView.addArrangedSubview(itemVoteAverageLabel)
        verticalStackView.addArrangedSubview(SpacerView(space: 6))
        verticalStackView.addArrangedSubview(itemGenresLabel)
    }
    
    func setViewConstraints() {
        cardBackgroundView.anchor(
            top: topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            bottom: bottomAnchor,
            topConstant: 6,
            leftConstant: 10,
            rightConstant: 10,
            bottomConstant: 6
        )
        
        itemImageView.anchor(
            top: cardBackgroundView.topAnchor,
            left: cardBackgroundView.leftAnchor,
            bottom: cardBackgroundView.bottomAnchor,
            topConstant: 4,
            leftConstant: 4,
            bottomConstant: 4,
            widthConstant: 58,
            heightConstant: 87
        )
        
        verticalStackView.anchorCenterYToSuperview()
        verticalStackView.anchor(
            left: itemImageView.rightAnchor,
            right: cardBackgroundView.rightAnchor,
            leftConstant: 12,
            rightConstant: 12
        )
    }
    
    func stylizeViews() {
        backgroundColor = AppColor.lightGray.uiColor
        selectionStyle = .none
        
        cardBackgroundView.backgroundColor = .white
        cardBackgroundView.layer.borderWidth = 0.5
        cardBackgroundView.layer.borderColor = UIColor.lightGray.cgColor
        
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        
        verticalStackView.distribution = .fill
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.spacing = 0
        
        itemTitleLabel.textColor = .black
        itemTitleLabel.font =  UIFont.boldSystemFont(ofSize: 14)
        
        itemSubtitleLabel.textColor = .black
        itemSubtitleLabel.font = UIFont.systemFont(ofSize: 12)
        
        itemGenresLabel.textColor = .darkGray
        itemGenresLabel.font = UIFont.systemFont(ofSize: 12)
    }
}
