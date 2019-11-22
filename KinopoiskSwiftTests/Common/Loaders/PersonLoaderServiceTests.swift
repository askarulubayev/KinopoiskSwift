//
//  PersonLoaderServiceTests.swift
//  KinopoiskSwiftTests
//
//  Created by Аскар on 11/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import XCTest
@testable import KinopoiskSwift

class PersonLoaderServiceTests: XCTestCase {
    
    private let networkService: NetworkService = NetworkAdapter()
    private lazy var loader = PersonLoaderService(networkService: networkService)
    
    func testPersonLoader() {
        let expectation1 = XCTestExpectation()
        loader.loadPopularPersons(page: 0) { result in
            switch result {
            case .success(let tvs):
                XCTAssertTrue(tvs.isEmpty)
            case .error(let error):
                XCTAssertTrue(!error.description.isEmpty)
            }
            expectation1.fulfill()
        }
        
        let expectation2 = XCTestExpectation()
        loader.loadPopularPersons(page: 1) { result in
            switch result {
            case .success(let tvs):
                XCTAssertTrue(!tvs.isEmpty)
            case .error(let error):
                XCTAssertTrue(!error.description.isEmpty)
            }
            expectation2.fulfill()
        }
        
        wait(
            for: [
                expectation1,
                expectation2
            ],
            timeout: 60
        )
    }
}
