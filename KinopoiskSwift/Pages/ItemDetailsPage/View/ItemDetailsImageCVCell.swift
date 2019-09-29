//
//  ItemDetailsImageCVCell.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class ItemDetailsImageCVCell: UICollectionViewCell, ReusableView {
    
    let imageView = CachedImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemDetailsImageCVCell: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(imageView)
    }
    
    func setViewConstraints() {
        imageView.fillSuperview()
    }
    
    func stylizeViews() {
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .lightGray
    }
}
