//
//  RepoPresenter.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI

protocol RepoPresentationLogic {
    func presentInfos(repository: Repository)
    func presentIssues(_ issues: [(Date, [Issue])])
    func presentError(_ error: NetworkError)
}

final class RepoPresenter: RepoPresentationLogic {
    weak var viewModel: RepoViewModelState?
    
    func presentInfos(repository: Repository) {
        var message = ""
        message += "Description: \(repository.description ?? "")\n\n"
        message += "Number of forks: \(repository.forksCount ?? 0)\n"
        message += "Number of watchers: \(repository.watchersCount ?? 0)\n"
        message += "Number of open issues: \(repository.openIssuesCount ?? 0)\n"
        
        viewModel?.displayInfos(message)
    }
    
    func presentIssues(_ issues: [(Date, [Issue])]) {
        let formattedIssues: [RepoViewModel.Issue] = issues.compactMap { issue in
            guard let date = issue.0.getFirstDayOfWeek() else {
                return nil
            }

            return RepoViewModel.Issue(id: UUID(), week: date, nbIssues: issue.1.count)
        }
        
        viewModel?.displayIssues(formattedIssues)
    }
    
    func presentError(_ error: NetworkError) {
        var errorMessage = "An error has occured"
        // IMPROVEMENTS: Create switch case here to handle every error
//            switch error {
//            default:
//                break
//            }
        viewModel?.displayError(message: errorMessage)
    }
}
