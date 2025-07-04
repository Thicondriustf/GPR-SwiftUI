//
//  RepoViewTests.swift
//  GPR-SwiftUITests
//
//  Created by Tommy Fernandez on 04/07/2025.
//

import XCTest
import ViewInspector
@testable import GPR_SwiftUI

final class RepoViewTests: XCTestCase {
    final class RepoInteractorSpy: RepoBusinessLogic {
        var getRepoInfosCalled = false
        
        func getRepoInfos() {
            getRepoInfosCalled = true
        }
        
        var getIssuesCalled = false
        
        func getIssues(startDate: Date) {
            getIssuesCalled = true
        }
    }
    
    func test_repoView_showsChart_whenHasIssues() throws {
        let viewModel = RepoViewModel()
        viewModel.isLoaded = true
        viewModel.issues = [RepoViewModel.Issue(id: UUID(), week: Date(), nbIssues: 1)]
        let view = RepoView(viewModel: viewModel)
        ViewHosting.host(view: view)

        XCTAssertNoThrow(try view.inspect().find(viewWithId: "RepoChart"))
    }
    
    func test_repoView_doesNotShowChart_whenIssuesIsEmpty() throws {
        let viewModel = RepoViewModel()
        viewModel.isLoaded = true
        viewModel.issues = []

        let view = RepoView(viewModel: viewModel)
        ViewHosting.host(view: view)
        
        XCTAssertThrowsError(try view.inspect().find(viewWithId: "RepoChart")) { error in
            XCTAssertTrue("\(error)".contains("Search did not find a match"))
        }
    }
    
    func test_repoView_showsAlert_whenErrorOccurs() throws {
        let viewModel = RepoViewModel()
        viewModel.errorMessage = "Erreur"
        viewModel.showAlert = true
        
        let view = RepoView(viewModel: viewModel)
        ViewHosting.host(view: view)
        
        let alert = try view.inspect().find(viewWithId: "RepoAlert")
        XCTAssertTrue(alert.isResponsive())
    }
    
    func test_repoView_displaysRepoInfo_whenLoaded() throws {
        let viewModel = RepoViewModel()
        viewModel.isLoaded = true
        viewModel.infos = "Repo full description here"
        let view = RepoView(viewModel: viewModel)
        ViewHosting.host(view: view)

        let text = try view.inspect().find(text: "Repo full description here")
        XCTAssertEqual(try text.string(), "Repo full description here")
    }
    
    func test_repoView_showsProgressView_whenNotLoaded() throws {
        let viewModel = RepoViewModel()
        viewModel.isLoaded = false
        let interactor = RepoInteractorSpy()
        let view = RepoView(interactor: interactor, viewModel: viewModel)
        ViewHosting.host(view: view)

        XCTAssertTrue(interactor.getRepoInfosCalled)
        XCTAssertTrue(interactor.getIssuesCalled)
        XCTAssertNoThrow(try view.inspect().find(viewWithId: "RepoProgressView"))
    }
}
