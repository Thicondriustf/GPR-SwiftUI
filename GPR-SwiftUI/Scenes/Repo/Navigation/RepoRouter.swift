//
//  RepoRouter.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI

protocol RepoRoutingLogic {
    func routeToIssues(at date: Date?) -> IssuesView?
}

protocol RepoDataPassing {
    var dataStore: RepoDataStore? { get set }
}

final class RepoRouter: RepoRoutingLogic, RepoDataPassing {
    var dataStore: RepoDataStore?

    // MARK: Routing

    func routeToIssues(at date: Date?) -> IssuesView? {
        guard let date = date, let weekIssue = dataStore?.weekIssues.first(where: { $0.0.weekOfYear == date.weekOfYear }), !weekIssue.1.isEmpty else {
            return nil
        }
        
        var view = IssuesConfigurator.initView()
        view.router?.dataStore?.week = weekIssue.0.toString(format: "MM/dd")
        view.router?.dataStore?.issues = weekIssue.1
        return view
    }
}
