//
//  MainPageHeaderTypesView.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class MainPageHeaderTypesView: UIView {
    
    let topSeperatorView = UIView()
    let horizontalStackView = UIStackView()
    let moviesPersonsSeperatorView = UIView()
    let personsTvShowsSeperatorView = UIView()
    let moviesView = ImageViewWithSubtitleView()
    let personsView = ImageViewWithSubtitleView()
    let tvShowsView = ImageViewWithSubtitleView()
    let bottomSeperatorView = UIView()
    
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
        addSubview(topSeperatorView)
        addSubview(moviesPersonsSeperatorView)
        addSubview(personsTvShowsSeperatorView)
        insertSubview(horizontalStackView, at: 0)
        horizontalStackView.addArrangedSubview(moviesView)
        horizontalStackView.addArrangedSubview(personsView)
        horizontalStackView.addArrangedSubview(tvShowsView)
        addSubview(bottomSeperatorView)
    }
    
    func setViewConstraints() {
        topSeperatorView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, heightConstant: 0.5)
        
        horizontalStackView.fillSuperview()
        
        moviesPersonsSeperatorView.anchor(top: topAnchor, bottom: bottomAnchor, widthConstant: 0.5)
        moviesPersonsSeperatorView.centerXAnchor.constraint(equalTo: moviesView.trailingAnchor).isActive = true
        
        personsTvShowsSeperatorView.anchor(top: topAnchor, bottom: bottomAnchor, widthConstant: 0.5)
        personsTvShowsSeperatorView.centerXAnchor.constraint(equalTo: tvShowsView.leadingAnchor).isActive = true
        
        bottomSeperatorView.anchor(left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, heightConstant: 0.5)
    }
    
    func stylizeViews() {
        topSeperatorView.backgroundColor = .lightGray
        
        horizontalStackView.backgroundColor = .green
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        
        moviesPersonsSeperatorView.backgroundColor = .lightGray
        
        personsTvShowsSeperatorView.backgroundColor = .lightGray
        
        moviesView.image = AppImage.films.uiImage
        moviesView.text = TmdbModelType.movie.title
        
        personsView.image = AppImage.actors.uiImage
        personsView.text = TmdbModelType.person.title
        
        tvShowsView.image = AppImage.tvShows.uiImage
        tvShowsView.text = TmdbModelType.tv.title
        
        bottomSeperatorView.backgroundColor = .lightGray
    }
}


