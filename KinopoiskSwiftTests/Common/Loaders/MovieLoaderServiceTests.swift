//
//  MovieLoaderServiceTests.swift
//  KinopoiskSwiftTests
//
//  Created by Аскар on 11/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import XCTest
@testable import KinopoiskSwift

class MovieLoaderServiceTests: XCTestCase {

    private let networkService: NetworkService = NetworkAdapter()
    private lazy var loader = MovieLoaderService(networkService: networkService)
    
    func testMovieLoaders() {
        let popularExpectation1 = XCTestExpectation()
        loader.loadPopularMovies(page: 1) { result in
            switch result {
            case .success(let movies):
                XCTAssertTrue(!movies.isEmpty)
            case .error(let error):
                XCTAssertTrue(!error.description.isEmpty)
            }
            popularExpectation1.fulfill()
        }
        
        
        let popularExpectation2 = XCTestExpectation()
        loader.loadPopularMovies(page: 0) { result in
            switch result {
            case .success(let movies):
                XCTAssertTrue(movies.isEmpty)
            case .error(let error):
                XCTAssertTrue(!error.description.isEmpty)
            }
            popularExpectation2.fulfill()
        }
        
        let popularExpectation3 = XCTestExpectation()
        loader.loadPopularMovies(page: -1) { result in
            switch result {
            case .success(let movies):
                XCTAssertTrue(movies.isEmpty)
            case .error(let error):
                XCTAssertTrue(!error.description.isEmpty)
            }
            popularExpectation3.fulfill()
        }
        
        let nowPlayingExpectation = XCTestExpectation()
        loader.loadNowPlayingMovies(page: 1) { result in
            switch result {
            case .success(let movies):
                XCTAssertTrue(!movies.isEmpty)
            case .error(let error):
                XCTAssertTrue(!error.description.isEmpty)
            }
            nowPlayingExpectation.fulfill()
        }
        
        let topRatedExpectation = XCTestExpectation()
        loader.loadTopRatedMovies(page: 1) { result in
            switch result {
            case .success(let movies):
                XCTAssertTrue(!movies.isEmpty)
            case .error(let error):
                XCTAssertTrue(!error.description.isEmpty)
            }
            topRatedExpectation.fulfill()
        }
        
        let upcomongExpectation = XCTestExpectation()
        loader.loadUpcomingMovies(page: 1) { result in
            switch result {
            case .success(let movies):
                XCTAssertTrue(!movies.isEmpty)
            case .error(let error):
                XCTAssertTrue(!error.description.isEmpty)
            }
            upcomongExpectation.fulfill()
        }
        
        wait(
            for: [
                popularExpectation1,
                popularExpectation2,
                popularExpectation3,
                nowPlayingExpectation,
                topRatedExpectation,
                upcomongExpectation
            ],
            timeout: 60
        )
    }
}
