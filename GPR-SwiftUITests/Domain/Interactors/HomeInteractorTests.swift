//
//  HomeInteractorTests.swift
//  GPRTests
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import XCTest
import NetworkingLayer
@testable import GPR_SwiftUI

final class HomeInteractorTests: XCTestCase {
    final class HomeInteractorSpy: HomePresentationLogic {
        var expectation: XCTestExpectation?
        init(expectation: XCTestExpectation?) {
            self.expectation = expectation
        }
        
        var presentRepositoriesCalled = false
        var presentedRepositories: [Repository] = []
        
        func presentRepositories(_ repositories: [Repository]) {
            presentRepositoriesCalled = true
            presentedRepositories = repositories
            expectation?.fulfill()
        }
        
        var presentErrorCalled = false
        
        func presentError(_ error: NetworkError) {
            presentErrorCalled = true
            expectation?.fulfill()
        }
        
        var presentIsFullyLoadedCalled = false
        
        func presentIsFullyLoaded() {
            presentIsFullyLoadedCalled = true
            expectation?.fulfill()
        }
    }
    
    final class HomeWorkerMock: HomeWorkerProtocol {
        private let result: NetworkResponse

        init(result: NetworkResponse) {
            self.result = result
        }

        func getRepositories(from id: Int) async -> NetworkResponse {
            return result
        }
    }
    
    func test_getNextPage_successWithRepositories_shouldPresentRepositories() {
        let expectation = expectation(description: "Retrieve repositories from API")
        let presenter = HomeInteractorSpy(expectation: expectation)
        let repositories = [Repository(id: 1, name: "repo", fullName: "repo/repo", description: nil, openIssuesCount: nil, forksCount: nil, watchersCount: nil)]
        let data = repositories.data!
        
        let worker = HomeWorkerMock(result: .success(data))
        let interactor = HomeInteractor(worker: worker)
        interactor.presenter = presenter
        
        interactor.getNextPage()
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(presenter.presentRepositoriesCalled)
        XCTAssertEqual(presenter.presentedRepositories.count, 1)
        XCTAssertEqual(presenter.presentedRepositories.first?.id, 1)
    }
    
    func test_getNextPage_successWithEmptyData_shouldPresentIsFullyLoaded() {
        let expectation = expectation(description: "Retrieve repositories from API")
        let presenter = HomeInteractorSpy(expectation: expectation)
        let repositories = [Repository]()
        let data = repositories.data!
        
        let worker = HomeWorkerMock(result: .success(data))
        let interactor = HomeInteractor(worker: worker)
        interactor.presenter = presenter

        interactor.getNextPage()
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(presenter.presentIsFullyLoadedCalled)
    }
    
    func test_getNextPage_failure_shouldPresentError() {
        let expectation = expectation(description: "Retrieve repositories from API")
        let presenter = HomeInteractorSpy(expectation: expectation)

        let worker = HomeWorkerMock(result: .failure(.networkMissing))
        let interactor = HomeInteractor(worker: worker)
        interactor.presenter = presenter

        interactor.getNextPage()
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(presenter.presentErrorCalled)
    }
    
    func test_getNextPage_whenIsLoading_shouldNotFetchAgain() async {
        let presenter = HomeInteractorSpy(expectation: nil)
        let repositories = [Repository(id: 1, name: "repo", fullName: "repo/repo", description: nil, openIssuesCount: nil, forksCount: nil, watchersCount: nil)]
        let data = repositories.data!
        
        let worker = HomeWorkerMock(result: .success(data))
        let interactor = HomeInteractor(worker: worker)
        interactor.presenter = presenter
        
        await withCheckedContinuation { continuation in
            Task { @MainActor in
                interactor.getNextPage()
                interactor.getNextPage() // Nothing must happen
                continuation.resume()
            }
        }
        
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        XCTAssertTrue(presenter.presentRepositoriesCalled)
        XCTAssertEqual(presenter.presentedRepositories.count, 1)
    }
}
