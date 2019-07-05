//
//  SearchPromptResultTVCell.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/31/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class SearchPromptResultTVCell: UITableViewCell, ReusableView {
    
    let resultImageView = CachedImageView()
    let verticalStackView = UIStackView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(model: TmdbModel) {
        resultImageView.loadImage(urlString: model.getPosterPathUrlString())
        titleLabel.text = model.getTitle()
        subtitleLabel.text = model.getSubtitle()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resultImageView.image = nil
    }
}

extension SearchPromptResultTVCell: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(resultImageView)
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleLabel)
    }
    
    func setViewConstraints() {
        resultImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, widthConstant: 38, heightConstant: 57)
        
        verticalStackView.anchor(left: resultImageView.rightAnchor, right: rightAnchor, leftConstant: 6, rightConstant: 16)
        verticalStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func stylizeViews() {
        resultImageView.backgroundColor = .lightGray
        resultImageView.contentMode = .scaleAspectFill
        
        verticalStackView.distribution = .fill
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 2
        
        titleLabel.textColor = UIColor.gray
        titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        
        subtitleLabel.textColor = UIColor.gray
        subtitleLabel.font = UIFont.systemFont(ofSize: 13)
    }
}
