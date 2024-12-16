//
//  RepoViewModel.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI

protocol RepoViewModelState: AnyObject {
    func displayInfos(_ infos: String)
    func displayIssues(_ issues: [RepoViewModel.Issue])
    func displayError(message: String)
}

class RepoViewModel: ObservableObject, RepoViewModelState {
    struct Issue: Identifiable {
        let id: UUID
        let week: Date
        let nbIssues: Int
    }
    
    // MARK: State
    
    @Published var infos: String = ""
    @Published var issues: [Issue] = []
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    
    var weeks: [Date] {
        return issues.map { $0.week }
    }
    
    func displayInfos(_ infos: String) {
        self.infos = infos
    }
    
    func displayIssues(_ issues: [Issue]) {
        self.issues = issues
    }
    
    func displayError(message: String) {
        errorMessage = message
        showAlert = true
    }
}
