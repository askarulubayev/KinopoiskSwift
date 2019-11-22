//
//  ItemDetailsMoviePresenterTests.swift
//  KinopoiskSwiftTests
//
//  Created by Аскар on 11/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import XCTest
@testable import KinopoiskSwift

class ItemDetailsMoviePresenterTests: XCTestCase {
    
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
    private let view = ItemDetailsViewTests()
    private let networkService: NetworkService = NetworkAdapter()
    private lazy var presenter = ItemDetailsMoviePresenter(view: view, model: movie, networkService: networkService)
    
    func test() {
        presenter.loadDetails()
        let expectation = XCTestExpectation()
        presenter.loadLastCredits { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    XCTAssertTrue(true)
                }
            case .error(let error):
                DispatchQueue.main.async {
                    XCTAssertTrue(!error.description.isEmpty)
                }
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
}
