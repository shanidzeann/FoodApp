//
//  NetworkingTests.swift
//  FoodAppTests
//
//  Created by Anna Shanidze on 12.04.2022.
//

import XCTest
@testable import FoodApp

class NetworkingTest: XCTestCase {

    var networkManager: NetworkManagerProtocol!
    
    override func setUpWithError() throws {
        networkManager = NetworkManager()
    }
    
    override func tearDownWithError() throws {
        networkManager = nil
    }
    
    func testGetMoviesSuccess() {
        let menuExpectation = expectation(description: "menu")
        
        networkManager.downloadMenu { results in
            if results.count > 0 {
                menuExpectation.fulfill()
            } else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
