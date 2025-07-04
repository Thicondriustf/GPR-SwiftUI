//
//  IssuesViewModel.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI

protocol IssuesViewModelState: AnyObject {
    func displayIssues(_ issues: [IssuesViewModel.Issue])
}

class IssuesViewModel: ObservableObject, IssuesViewModelState {
    struct Issue: Identifiable {
        var id: UUID
        let title: String
        let status: String
    }
    
    // MARK: State
    
    @Published var issues: [Issue] = []
    
    func displayIssues(_ issues: [Issue]) {
        self.issues = issues
    }
}
