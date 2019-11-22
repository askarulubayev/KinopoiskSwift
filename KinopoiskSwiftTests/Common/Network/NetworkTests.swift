//
//  NetworkTests.swift
//  KinopoiskSwiftTests
//
//  Created by Аскар on 11/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import XCTest
@testable import KinopoiskSwift

class NetworkTests: XCTestCase {
    
    private let networkService: NetworkService = NetworkAdapter()
    
    func testNetworkService() {
        let expectation = XCTestExpectation()
        
        networkService.loadDecodable(context: TVGenresNetworkContext(), type: Genres.self) { result in
            switch result {
            case .success(let genres):
                XCTAssertTrue(!genres.genres.isEmpty)
            case .error(let error):
                XCTAssertTrue(!error.description.isEmpty)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
    }
}
