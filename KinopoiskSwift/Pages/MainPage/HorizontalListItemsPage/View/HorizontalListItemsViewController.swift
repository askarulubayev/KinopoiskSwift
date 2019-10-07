//
//  HorizontalListItemsViewController.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/25/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class HorizontalListItemsViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var models = [TmdbModel]()
    private var isLoading = true
    
    func set(models: [TmdbModel]) {
        self.models = models
        collectionView.reloadData()
    }
    
    func hideLoadingState() {
        isLoading = false
    }
    
    func showLoadingState() {
        isLoading = true
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylizeViews()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isLoading ? 10 : models.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HorizontalListItemCVCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        isLoading ? cell.showLoadingState() : cell.hideLoadingState()
        if !isLoading {
            cell.set(model: models[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: HorizontalListItemsTVCell.getCellWidth(), height: HorizontalListItemsTVCell.getCellHeight())
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let navigationController = navigationController as? NavigationController else { return }
        let _ = ItemDetailsRouter(model: models[indexPath.row], navigationController: navigationController, networkService: NetworkAdapter())
    }
}

extension HorizontalListItemsViewController {
    private func  stylizeViews() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(cell: HorizontalListItemCVCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
}
