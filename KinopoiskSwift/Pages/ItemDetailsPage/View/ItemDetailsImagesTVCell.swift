//
//  ItemDetailsImagesTVCell.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class ItemDetailsImagesTVCell: UITableViewCell, ReusableView {
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: HorizontalCVLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageUrlStrings: [String]?
    
    func set(imageUrlStrings: [String]) {
        self.imageUrlStrings = imageUrlStrings
    }
}

extension ItemDetailsImagesTVCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrlStrings?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ItemDetailsImageCVCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.imageView.loadImage(urlString: imageUrlStrings?[indexPath.row])
        return cell
    }
}

extension ItemDetailsImagesTVCell: UICollectionViewDelegate {
    
}

extension ItemDetailsImagesTVCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        return CGSize(width: 80, height: 120)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        
        return 8
    }
}

extension ItemDetailsImagesTVCell: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(collectionView)
    }
    
    func setViewConstraints() {
        collectionView.anchor(
            top: topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            bottom: bottomAnchor,
            topConstant: 12,
            bottomConstant: 12,
            heightConstant: 100
        )
    }
    
    func stylizeViews() {
        selectionStyle = .none
        
        collectionView.register(cell: ItemDetailsImageCVCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
