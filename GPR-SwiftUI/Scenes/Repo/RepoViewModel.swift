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
    
    @Published var isLoaded = false
    @Published var infos: String = ""
    @Published var issues: [Issue] = []
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    
    var hasIssues: Bool {
        return issues.contains(where: { $0.nbIssues > 0})
    }
    
    func displayInfos(_ infos: String) {
        self.infos = infos
        isLoaded = true
    }
    
    func displayIssues(_ issues: [Issue]) {
        self.issues = issues
    }
    
    func displayError(message: String) {
        errorMessage = message
        showAlert = true
        isLoaded = true
    }
}
