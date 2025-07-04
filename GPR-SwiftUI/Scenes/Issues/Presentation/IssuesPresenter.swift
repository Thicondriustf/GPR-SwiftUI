//
//  IssuesPresenter.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import Foundation

protocol IssuesPresentationLogic {
    func presentIssues(_ issues: [Issue])
}

final class IssuesPresenter: IssuesPresentationLogic {
    weak var viewModel: IssuesViewModelState?
    
    func presentIssues(_ issues: [Issue]) {
        let issues = issues.map { issue in
            let state: String
            if issue.state == .open {
                state = "Open"
            } else {
                state = "Closed"
            }
            return IssuesViewModel.Issue(id: UUID(), title: issue.title, status: state)
        }
        viewModel?.displayIssues(issues)
    }
}
