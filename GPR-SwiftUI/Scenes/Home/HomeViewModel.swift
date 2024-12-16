//
//  HomeViewModel.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI

protocol HomeViewModelState: AnyObject {
    func displayRepositories(_ repositories: [HomeViewModel.Repository])
    func displayError(message: String)
}

class HomeViewModel: ObservableObject, HomeViewModelState {
    struct Repository: Identifiable {
        var id: Int
        let title: String
        let description: String
    }
    
    // MARK: State
    
    @Published var repositories: [Repository] = []
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    
    func displayRepositories(_ repositories: [Repository]) {
        self.repositories = repositories
    }
    
    func displayError(message: String) {
        errorMessage = message
        showAlert = true
    }
}
