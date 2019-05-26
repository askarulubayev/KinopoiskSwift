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
    let bottomSeperatorView = UIView()
    
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
}

// MARK: - extension for animation when view tapped
extension ImageViewWithSubtitleView {
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
                    self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            })
        } else {
            UIView.animate(
                withDuration: 0.8,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0,
                options: animationOptions,
                animations: {
                    self.backgroundColor = UIColor.white
            })
        }
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
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = stackViewSpacing
        
        imageView.contentMode = .scaleAspectFit
        
        subtitleLabel.textColor = AppColor.darkGray.uiColor
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.textAlignment = .center
    }
}
