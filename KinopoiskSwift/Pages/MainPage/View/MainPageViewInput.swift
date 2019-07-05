//
//  MainPageViewInput.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/22/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

protocol MainPageViewInput: BaseViewInputProtocol {
    func set(upcomingMovies: [Movie])
    func set(headerComponents: [MainPageHeaderComponent])
    func set(searchResult: [TmdbModel])
}
