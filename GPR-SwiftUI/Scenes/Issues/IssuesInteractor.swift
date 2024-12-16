//
//  IssuesInteractor.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

protocol IssuesBusinessLogic {
    func retrieveIssues()
}

protocol IssuesDataStore {
    var week: String { get set }
    var issues: [Issue] { get set }
}

final class IssuesInteractor: IssuesBusinessLogic, IssuesDataStore {
    var presenter: IssuesPresentationLogic?
    var week: String = ""
    var issues: [Issue] = []

    func retrieveIssues() {
        presenter?.presentIssues(issues)
    }
}
