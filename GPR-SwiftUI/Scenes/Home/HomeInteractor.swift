//
//  HomeInteractor.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

protocol HomeBusinessLogic {
    func getNextPage()
}

protocol HomeDataStore {
    var repositories: [Repository] { get set }
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var repositories: [Repository] = []
    
    private var isLoading: Bool = false

    func getNextPage() {
        Task { @MainActor in
            guard !isLoading else {
                return
            }
            
            isLoading = true
            var id = 0
            if let repoId = repositories.last?.id {
                id = repoId
            }
            
            let response = await HomeWorker().getRepositories(from: id)
            switch response {
            case .success(let data):
                guard let result = [Repository].decode(from: data) else {
                    self.presenter?.presentError(.undecodable)
                    return
                }
                
                if result.isEmpty {
                    presenter?.presentIsFullyLoaded()
                } else {
                    repositories.append(contentsOf: result)
                    presenter?.presentRepositories(repositories)
                }
            case .failure(let error):
                presenter?.presentError(error)
            }
            
            isLoading = false
        }
    }
}
