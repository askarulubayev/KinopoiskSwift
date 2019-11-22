//
//  ItemDetailsViewTests.swift
//  KinopoiskSwiftTests
//
//  Created by Аскар on 11/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import XCTest
@testable import KinopoiskSwift

class ItemDetailsViewTests: XCTestCase, ItemDetailsViewInput {
    
    private let movie = Movie(
        id: 1,
        title: "test",
        original_title: "test originalTitle",
        poster_path: "test",
        backdrop_path: "test",
        vote_average: 7.0,
        overview: "test overview",
        release_date: "1998-09-02",
        popularity: 5000.0,
        original_language: "eng",
        genre_ids: [1,2,3],
        vote_count: 7000,
        video: false,
        adult: true,
        media_type: .movie
    )
    
    private let networkService: NetworkService = NetworkAdapter()
    private var presenter: ItemDetailsMoviePresenter!
    
    override func setUp() {
        presenter = ItemDetailsMoviePresenter(view: self, model: movie, networkService: networkService)
        presenter.loadDetails()
    }
    
    func set(headerModel: TmdbDetailsModel) {
        XCTAssertTrue(false)
    }
    
    func set(headerComponents: [ItemDetailHeaderComponent]) {
        XCTAssertTrue(false)
    }
    
    func showActivityIndicator() {
        print("showActivityIndicator")
    }
    
    func hideActivityIndicator() {
        print("hideActivityIndicator")
    }
}
