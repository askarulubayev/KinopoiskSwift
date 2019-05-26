//
//  MainPageHeaderView.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class MainPageHeaderView: UIView {
    
    let headerViewController = MainPageHeaderViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movies: [Movie]) {
        headerViewController.set(movies: movies)
    }
}

extension MainPageHeaderView: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(headerViewController.view)
    }
    
    func setViewConstraints() {
        headerViewController.view.fillSuperview()
    }
    
    func stylizeViews() {}
}
