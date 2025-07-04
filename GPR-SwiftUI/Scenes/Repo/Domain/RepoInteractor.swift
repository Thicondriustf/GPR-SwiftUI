//
//  RepoInteractor.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import Foundation

protocol RepoBusinessLogic {
    func getRepoInfos()
    func getIssues(startDate: Date)
}

protocol RepoDataStore {
    var name: String { get set }
    var fullName: String { get set }
    var weekIssues: [(Date, [Issue])] { get set }
}

final class RepoInteractor: RepoBusinessLogic, RepoDataStore {
    var presenter: RepoPresentationLogic?
    var name: String = ""
    var fullName: String = ""
    var issues = [Issue]()
    var weekIssues = [(Date, [Issue])]()
    
    private let worker: RepoWorkerProtocol
    
    init(worker: RepoWorkerProtocol = RepoWorker()) {
        self.worker = worker
    }
    
    func getRepoInfos() {
        Task { @MainActor in
            let response = await worker.getRepository(name: fullName)
            switch response {
            case .success(let data):
                guard let result = Repository.decode(from: data) else {
                    presenter?.presentError(.undecodable)
                    return
                }

                presenter?.presentInfos(repository: result)
            case .failure(let error):
                presenter?.presentError(error)
            }
        }
    }
    
    func getIssues(startDate: Date) {
        issues.removeAll()
        weekIssues.removeAll()
        getIssues(startDate: startDate, page: 1)
    }
    
    private func getIssues(startDate: Date, page: Int) {
        Task { @MainActor in
            let response = await worker.getIssues(name: fullName, from: startDate, page: page)
            switch response {
            case .success(let data):
                guard let result = [Issue].decode(from: data) else {
                    self.presenter?.presentError(.undecodable)
                    return
                }

                // Filtering issues to only handle the one created after the start date and removing all PRs
                let filteredResult = result.filter { issue in
                    return issue.createdAt >= startDate && issue.draft == nil
                }
                
                self.issues.append(contentsOf: filteredResult)
                
                if result.isEmpty {
                    self.createFormatedIssues(startDate: startDate)
                } else {
                    self.getIssues(startDate: startDate, page: page + 1)
                }
            case .failure(let error):
                self.presenter?.presentError(error)
            }
        }
    }
    
    /// Regroup issues to the week they are in
    /// - Parameter startDate: Starting week
    private func createFormatedIssues(startDate: Date) {
        weekIssues = self.createDefaultIssues(from: startDate)
        for issue in self.issues {
            if let index = weekIssues.firstIndex(where: { i in
                return i.0.year == issue.createdAt.year && i.0.weekOfYear == issue.createdAt.weekOfYear
            }) {
                weekIssues[index].1.append(issue)
            }
        }
        
        self.presenter?.presentIssues(weekIssues)
    }
    
    /// Initialize a variable to divide weeks in group
    /// - Parameter startDate:Starting week of the variable
    /// - Returns: Returned initialize variable to be filled
    private func createDefaultIssues(from startDate: Date) -> [(Date, [Issue])] {
        var date = startDate
        let now = Date()
        var issues = [(Date, [Issue])]()
        while date < now {
            issues.append((date, []))
            date = date.addingTimeInterval(7 * 24 * 3600)
        }
        
        return issues
    }
}
