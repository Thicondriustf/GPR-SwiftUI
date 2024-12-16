//
//  HomeInteractorTests.swift
//  GPRTests
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import XCTest
@testable import GPR_SwiftUI

final class HomeInteractorTests: XCTestCase {
    final class HomeInteractorSpy: HomePresentationLogic {
        var expectation: XCTestExpectation
        init(expectation: XCTestExpectation) {
            self.expectation = expectation
        }
        
        var presentRepositoriesCalled = false
        func presentRepositories(_ repositories: [Repository]) {
            presentRepositoriesCalled = true
            expectation.fulfill()
        }
        
        var presentErrorCalled = false
        
        func presentError(_ error: NetworkError) {
            presentErrorCalled = true
            expectation.fulfill()
        }
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHomeInteractorGetNextPage() throws {
        // Create expectaction for async testing due to API call
        let expectation = expectation(description: "Retrieve repositories from API")
        let homeInteractor = HomeInteractor()
        let homeInteractorSpy = HomeInteractorSpy(expectation: expectation)
        homeInteractor.presenter = homeInteractorSpy
        
        homeInteractor.getNextPage()
        waitForExpectations(timeout: 60)
        
        XCTAssert(homeInteractorSpy.presentRepositoriesCalled && !homeInteractorSpy.presentErrorCalled
                  || !homeInteractorSpy.presentRepositoriesCalled && homeInteractorSpy.presentErrorCalled)
    }
}
