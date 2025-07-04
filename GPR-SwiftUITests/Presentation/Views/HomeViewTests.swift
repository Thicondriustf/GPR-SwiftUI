//
//  HomeViewTests.swift
//  GPR-SwiftUITests
//
//  Created by Tommy Fernandez on 04/07/2025.
//

import XCTest
import ViewInspector
@testable import GPR_SwiftUI

final class HomeViewTests: XCTestCase {
    final class HomeInteractorSpy: HomeBusinessLogic {
        var getNextPageCalled = false
        
        func getNextPage() {
            getNextPageCalled = true
        }
    }
    
    func test_homeView_displaysRepositories() {
        let viewModel = HomeViewModel()
        viewModel.repositories = [
            HomeViewModel.Repository(id: 1, title: "Repo-1", description: "Description 1"),
            HomeViewModel.Repository(id: 1, title: "Repo-2", description: "Description 2")
        ]
        
        let view = HomeView(viewModel: viewModel)

        ViewHosting.host(view: view)

        XCTAssertNoThrow(try view.inspect().find(text: "Repo-1"))
        XCTAssertNoThrow(try view.inspect().find(text: "Repo-2"))
    }
    
    func test_homeView_showsAlert_whenErrorOccurs() throws {
        let viewModel = HomeViewModel()
        viewModel.errorMessage = "Erreur"
        viewModel.showAlert = true
        
        let view = HomeView(viewModel: viewModel)
        ViewHosting.host(view: view)
        
        let alert = try view.inspect().find(viewWithId: "HomeAlert")
        XCTAssertTrue(alert.isResponsive())
    }
    
    func test_homeView_callsGetNextPage_whenProgressViewAppears() {
        let interactor = HomeInteractorSpy()
        let viewModel = HomeViewModel()
        viewModel.repositories = []
        viewModel.isFullyLoaded = false
        
        let view = HomeView(router: nil, interactor: interactor, viewModel: viewModel)
        ViewHosting.host(view: view)

        XCTAssertTrue(interactor.getNextPageCalled)
    }
}
