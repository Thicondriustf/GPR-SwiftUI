//
//  RepoInteractorTests.swift
//  GPRTests
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import XCTest
@testable import GPR_SwiftUI

final class RepoInteractorTests: XCTestCase {
    final class RepoInteractorSpy: RepoPresentationLogic {
        var expectation: XCTestExpectation
        init(expectation: XCTestExpectation) {
            self.expectation = expectation
        }
        
        var presentInfosCalled = false
        
        func presentInfos(repository: Repository) {
            presentInfosCalled = true
            expectation.fulfill()
        }
        
        var presentIssuesCalled = false
        
        func presentIssues(_ issues: [(Date, [Issue])]) {
            presentIssuesCalled = true
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

    func testRepoInteractorGetRepoInfos() throws {
        // Create expectaction for async testing due to API call
        let expectation = expectation(description: "Retrieve repositories from API")
        let repoInteractor = RepoInteractor()
        repoInteractor.fullName = "github/codeql"
        let repoInteractorSpy = RepoInteractorSpy(expectation: expectation)
        repoInteractor.presenter = repoInteractorSpy
        
        repoInteractor.getRepoInfos()
        waitForExpectations(timeout: 60)
        
        XCTAssert(repoInteractorSpy.presentInfosCalled && !repoInteractorSpy.presentErrorCalled
                  || !repoInteractorSpy.presentInfosCalled && repoInteractorSpy.presentErrorCalled)
    }
    
    func testRepoInteractorGetIssues() throws {
        // Create expectaction for async testing due to API call
        let expectation = expectation(description: "Retrieve repositories from API")
        let repoInteractor = RepoInteractor()
        repoInteractor.fullName = "github/codeql"
        let repoInteractorSpy = RepoInteractorSpy(expectation: expectation)
        repoInteractor.presenter = repoInteractorSpy
        
        repoInteractor.getIssues(startDate: Date().addingTimeInterval(-7 * 4 * 24 * 3600))
        waitForExpectations(timeout: 60)
        
        XCTAssert(repoInteractorSpy.presentIssuesCalled && !repoInteractorSpy.presentErrorCalled
                  || !repoInteractorSpy.presentIssuesCalled && repoInteractorSpy.presentErrorCalled)
    }
    
    func testRepoInteractorWithoutFullName() throws {
        // Create expectaction for async testing due to API call
        let expectation = expectation(description: "Retrieve repositories from API")
        let repoInteractor = RepoInteractor()
        let repoInteractorSpy = RepoInteractorSpy(expectation: expectation)
        repoInteractor.presenter = repoInteractorSpy
        
        repoInteractor.getIssues(startDate: Date().addingTimeInterval(-7 * 4 * 24 * 3600))
        waitForExpectations(timeout: 60)
        
        XCTAssert(repoInteractorSpy.presentErrorCalled)
    }
}
