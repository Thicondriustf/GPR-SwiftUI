//
//  HomePresenter.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import NetworkingLayer

protocol HomePresentationLogic {
    func presentRepositories(_ repositories: [Repository])
    func presentIsFullyLoaded()
    func presentError(_ error: NetworkError)
}

final class HomePresenter: HomePresentationLogic {
    weak var viewModel: HomeViewModelState?
    
    func presentRepositories(_ repositories: [Repository]) {
        let repositories = repositories.map { repository in
            return HomeViewModel.Repository(id: repository.id, title: repository.name, description: repository.description ?? "")
        }
        viewModel?.displayRepositories(repositories)
    }
    
    func presentIsFullyLoaded() {
        viewModel?.displayIsFullyLoaded()
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
