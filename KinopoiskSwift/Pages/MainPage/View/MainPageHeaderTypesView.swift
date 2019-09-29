//
//  MainPageHeaderTypesView.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class MainPageHeaderTypesView: UIView {
    
    private let topSeparatorView = UIView()
    private let horizontalStackView = UIStackView()
    private let moviesPersonsSeperatorView = UIView()
    private let personsTvShowsSeperatorView = UIView()
    private let moviesView = ImageViewWithSubtitleView()
    private let personsView = ImageViewWithSubtitleView()
    private let tvShowsView = ImageViewWithSubtitleView()
    private let bottomSeparatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainPageHeaderTypesView: ViewInstallationProtocol {
    func addSubviews() {
        addSubview(topSeparatorView)
        addSubview(moviesPersonsSeperatorView)
        addSubview(personsTvShowsSeperatorView)
        insertSubview(horizontalStackView, at: 0)
        horizontalStackView.addArrangedSubview(moviesView)
        horizontalStackView.addArrangedSubview(personsView)
        horizontalStackView.addArrangedSubview(tvShowsView)
        addSubview(bottomSeparatorView)
    }
    
    func setViewConstraints() {
        topSeparatorView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, heightConstant: 0.5)
        
        horizontalStackView.fillSuperview()
        
        moviesPersonsSeperatorView.anchor(top: topAnchor, bottom: bottomAnchor, widthConstant: 0.5)
        moviesPersonsSeperatorView.centerXAnchor.constraint(equalTo: moviesView.trailingAnchor).isActive = true
        
        personsTvShowsSeperatorView.anchor(top: topAnchor, bottom: bottomAnchor, widthConstant: 0.5)
        personsTvShowsSeperatorView.centerXAnchor.constraint(equalTo: tvShowsView.leadingAnchor).isActive = true
        
        bottomSeparatorView.anchor(left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, heightConstant: 0.5)
    }
    
    func stylizeViews() {
        topSeparatorView.backgroundColor = AppColor.lightGray.uiColor
        
        horizontalStackView.backgroundColor = .green
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        
        moviesPersonsSeperatorView.backgroundColor = AppColor.lightGray.uiColor
        
        personsTvShowsSeperatorView.backgroundColor = AppColor.lightGray.uiColor
        
        moviesView.image = AppImage.films.uiImage
        moviesView.text = TmdbModelType.movie.title
        
        personsView.image = AppImage.actors.uiImage
        personsView.text = TmdbModelType.person.title
        
        tvShowsView.image = AppImage.tvShows.uiImage
        tvShowsView.text = TmdbModelType.tv.title
        
        bottomSeparatorView.backgroundColor = AppColor.lightGray.uiColor
    }
}


