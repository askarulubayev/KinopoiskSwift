//
//  ImageViewWithSubtitleView.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class ImageViewWithSubtitleView: UIView {
    
    let verticalStackView = UIStackView()
    let imageView = UIImageView()
    let subtitleLabel = UILabel()
    
    var image: UIImage? {
        didSet {
            imageView.image = image?.resized(to: imageSize)
        }
    }
    
    var imageSize = CGSize(width: 36, height: 36) {
        didSet {
            imageView.image = image?.resized(to: imageSize)
        }
    }
    
    var text: String? {
        didSet {
            subtitleLabel.text = text
        }
    }
    
    var stackViewSpacing: CGFloat = 6
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoadingState() {
        verticalStackView.showAnimatedSkeleton()
    }
    
    func hideLoadingState() {
        verticalStackView.hideSkeleton()
    }
}

extension ImageViewWithSubtitleView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        setupDefaultClickAnimation(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        setupDefaultClickAnimation(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        setupDefaultClickAnimation(isHighlighted: false)
    }
}

extension ImageViewWithSubtitleView: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(subtitleLabel)
    }
    
    func setViewConstraints() {
        verticalStackView.anchorCenterYToSuperview()
        verticalStackView.anchor(left: leftAnchor, right: rightAnchor, leftConstant: 8, rightConstant: 8)
        
        imageView.anchor(widthConstant: 36, heightConstant: 36)
    }
    
    func stylizeViews() {
        backgroundColor = .white
        isSkeletonable = false
        
        verticalStackView.isSkeletonable = false
        verticalStackView.axis = .vertical
        verticalStackView.spacing = stackViewSpacing
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .center
        
        imageView.isSkeletonable = true
        imageView.contentMode = .scaleAspectFit
        
        subtitleLabel.isSkeletonable = true
        subtitleLabel.textColor = AppColor.darkGray.uiColor
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.textAlignment = .center
    }
}
