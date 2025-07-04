//
//  RepoInteractorTests.swift
//  GPRTests
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import XCTest
import NetworkingLayer
@testable import GPR_SwiftUI

final class RepoInteractorTests: XCTestCase {
    final class RepoInteractorSpy: RepoPresentationLogic {
        var expectation: XCTestExpectation
        init(expectation: XCTestExpectation) {
            self.expectation = expectation
        }
        
        var presentInfosCalled = false
        var presentedRepository: Repository?
        
        func presentInfos(repository: Repository) {
            presentInfosCalled = true
            presentedRepository = repository
            expectation.fulfill()
        }
        
        var presentIssuesCalled = false
        var presentedIssues: [(Date, [Issue])]?
        
        func presentIssues(_ issues: [(Date, [Issue])]) {
            presentIssuesCalled = true
            presentedIssues = issues
            expectation.fulfill()
        }
        
        var presentErrorCalled = false
        
        func presentError(_ error: NetworkError) {
            presentErrorCalled = true
            expectation.fulfill()
        }
    }
    
    final class RepoWorkerMock: RepoWorkerProtocol {
        private let repoResponse: NetworkResponse?
        private let issuesResponses: [NetworkResponse]

        init(repoResponse: NetworkResponse?, issuesResponses: [NetworkResponse]) {
            self.repoResponse = repoResponse
            self.issuesResponses = issuesResponses
        }

        func getRepository(name: String) async -> NetworkResponse {
            return repoResponse ?? .failure(.unknown)
        }

        var callCount = 0

        func getIssues(name: String, from startDate: Date, page: Int) async -> NetworkResponse {
            guard callCount < issuesResponses.count else {
                return .success([Issue]().data!)
            }

            defer {
                callCount += 1
            }
            return issuesResponses[callCount]
        }
    }


    func test_getRepoInfos_success_shouldPresentRepository() {
        let expectation = expectation(description: "Retrieve repository from API")
        let presenter = RepoInteractorSpy(expectation: expectation)

        let repository = Repository(id: 1, name: "Test Repo", fullName: "Test/Repo", description: nil, openIssuesCount: nil, forksCount: nil, watchersCount: nil)
        let data = repository.data!
        let worker = RepoWorkerMock(repoResponse: .success(data), issuesResponses: [])

        let interactor = RepoInteractor(worker: worker)
        interactor.fullName = "Test/Repo"
        interactor.presenter = presenter

        interactor.getRepoInfos()
        
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(presenter.presentInfosCalled)
        XCTAssertEqual(presenter.presentedRepository?.id, 1)
    }

    func test_getRepoInfos_failure_shouldPresentError() {
        let expectation = expectation(description: "Retrieve repositories from API")
        let presenter = RepoInteractorSpy(expectation: expectation)
        
        let worker = RepoWorkerMock(repoResponse: .failure(.networkMissing), issuesResponses: [])
        let interactor = RepoInteractor(worker: worker)
        interactor.presenter = presenter

        interactor.getRepoInfos()
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(presenter.presentErrorCalled)
    }
    
    func test_getIssues_multiplePages_shouldGroupByWeek() {
        let expectation = expectation(description: "Presenter should be called")
        let presenter = RepoInteractorSpy(expectation: expectation)
        let startDate = Calendar.current.date(byAdding: .day, value: -14, to: Date())!

        let issuePage1 = Issue(createdAt: startDate.addingTimeInterval(3600), title: "Issue 1", state: .open)
        let issuePage2 = Issue(createdAt: startDate.addingTimeInterval(8 * 24 * 3600), title: "Issue 2", state: .open)
        let data1 = [issuePage1].data!
        let data2 = [issuePage2].data!
        
        let worker = RepoWorkerMock(repoResponse: nil, issuesResponses: [.success(data1), .success(data2)])

        let interactor = RepoInteractor(worker: worker)
        interactor.fullName = "Test/Repo"
        interactor.presenter = presenter

        interactor.getIssues(startDate: startDate)

        waitForExpectations(timeout: 5)

        XCTAssertTrue(presenter.presentIssuesCalled)
        XCTAssertEqual(presenter.presentedIssues?.count, 3)
        XCTAssertEqual(presenter.presentedIssues?.flatMap(\.1).count, 2)
    }
}
