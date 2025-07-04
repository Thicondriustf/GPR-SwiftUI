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
        var presentedIssues: [Issue] = []

        func presentIssues(_ issues: [Issue]) {
            presentIssuesCalled = true
            presentedIssues = issues
        }
    }
    
    func test_retrieveIssues_shouldCallPresenterWithIssues() {
        let presenter = IssuesInteractorSpy()
        let interactor = IssuesInteractor()
        interactor.presenter = presenter
        let mockIssues = [
            Issue(createdAt: Date(), title: "Issue 1", state: .open),
            Issue(createdAt: Date(), title: "Issue 2", state: .open)
        ]
        interactor.issues = mockIssues
        
        interactor.retrieveIssues()
        
        XCTAssertTrue(presenter.presentIssuesCalled)
        XCTAssertEqual(presenter.presentedIssues.count, mockIssues.count)
        XCTAssertEqual(presenter.presentedIssues.map(\.title), mockIssues.map(\.title))
    }
}
