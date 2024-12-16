//
//  IssuesInteractorTests.swift
//  GPRTests
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import XCTest
@testable import GPR_SwiftUI

final class IssuesInteractorTests: XCTestCase {
    final class IssuesInteractorSpy: IssuesPresentationLogic {
        var presentIssuesCalled = false
        
        func presentIssues(_ issues: [Issue]) {
            presentIssuesCalled = true
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

    func testIssuesInteractorRetrieveIssuesEmpty() throws {
        let issuesInteractor = IssuesInteractor()
        let issuesInteractorSpy = IssuesInteractorSpy()
        issuesInteractor.presenter = issuesInteractorSpy
        
        issuesInteractor.retrieveIssues()
        
        XCTAssert(issuesInteractorSpy.presentIssuesCalled)
    }
    
    func testIssuesInteractorRetrieveIssuesNonEmpty() throws {
        let issuesInteractor = IssuesInteractor()
        issuesInteractor.issues = [Issue(createdAt: Date(), title: "Title", state: .open)]
        let issuesInteractorSpy = IssuesInteractorSpy()
        issuesInteractor.presenter = issuesInteractorSpy
        
        issuesInteractor.retrieveIssues()
        
        XCTAssert(issuesInteractorSpy.presentIssuesCalled)
    }
}
