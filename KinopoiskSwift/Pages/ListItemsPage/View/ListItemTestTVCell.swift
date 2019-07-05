//
//  ListItemTestTVCell.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/22/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class ListItemTestTVCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var itemImageView: CachedImageView!
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemSubtitleLabel: UILabel!
    @IBOutlet weak var itemVoteAverageLabel: UILabel!
    @IBOutlet weak var itemGenresLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stylizeViews()
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
        itemTitleLabel.text = model.getTitle()
        itemImageView.loadImage(urlString: model.getPosterPathUrlString())
        itemSubtitleLabel.text = model.getSubtitle()
        if let movieTVShowModel = model as? TmdbMovieTVShowModel {
            itemGenresLabel.text = movieTVShowModel.overview
            itemVoteAverageLabel.attributedText = movieTVShowModel.getVoteAverageWithPopularity()
        }
    }
}

extension ListItemTestTVCell {
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

extension ListItemTestTVCell {
    private func stylizeViews() {
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
