//
//  TVShowLoaderServiceTests.swift
//  KinopoiskSwiftTests
//
//  Created by Аскар on 11/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import XCTest
@testable import KinopoiskSwift

class TVShowLoaderServiceTests: XCTestCase {
    
    private let networkService: NetworkService = NetworkAdapter()
    private lazy var loader = TVShowLoaderService(networkService: networkService)
    
    func testTVShowLoader() {
        let popularExpectation1 = XCTestExpectation()
        loader.loadPopularTVShows(page: 1) { result in
            switch result {
            case .success(let tvs):
                XCTAssertTrue(!tvs.isEmpty)
            case .error(let error):
                XCTAssertTrue(!error.description.isEmpty)
            }
            popularExpectation1.fulfill()
        }
        
        let popularExpectation2 = XCTestExpectation()
        loader.loadPopularTVShows(page: 0) { result in
            switch result {
            case .success(let tvs):
                XCTAssertTrue(tvs.isEmpty)
            case .error(let error):
                XCTAssertTrue(!error.description.isEmpty)
            }
            popularExpectation2.fulfill()
        }
        
        let popularExpectation3 = XCTestExpectation()
        loader.loadPopularTVShows(page: -1) { result in
            switch result {
            case .success(let tvs):
                XCTAssertTrue(tvs.isEmpty)
            case .error(let error):
                XCTAssertTrue(!error.description.isEmpty)
            }
            popularExpectation3.fulfill()
        }
        
        let airingTodayExpectation = XCTestExpectation()
        loader.loadAiringTodayTVShows(page: 1) { result in
            switch result {
            case .success(let tvs):
                XCTAssertTrue(!tvs.isEmpty)
            case .error(let error):
                XCTAssertTrue(!error.description.isEmpty)
            }
            airingTodayExpectation.fulfill()
        }
        
        let onTheAirExpectation = XCTestExpectation()
        loader.loadOnTheAirTVShows(page: 1) { result in
            switch result {
            case .success(let tvs):
                XCTAssertTrue(!tvs.isEmpty)
            case .error(let error):
                XCTAssertTrue(!error.description.isEmpty)
            }
            onTheAirExpectation.fulfill()
        }
        
        let topRatedExpectation = XCTestExpectation()
        loader.loadTopRatedTVShows(page: 1) { result in
            switch result {
            case .success(let tvs):
                XCTAssertTrue(!tvs.isEmpty)
            case .error(let error):
                XCTAssertTrue(!error.description.isEmpty)
            }
            topRatedExpectation.fulfill()
        }
        
        wait(
            for: [
                popularExpectation1,
                popularExpectation2,
                popularExpectation3,
                airingTodayExpectation,
                onTheAirExpectation,
                topRatedExpectation
            ],
            timeout: 60
        )
    }
}
