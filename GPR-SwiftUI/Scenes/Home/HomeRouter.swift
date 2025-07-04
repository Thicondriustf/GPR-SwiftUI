//
//  HomeRouter.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI

protocol HomeRoutingLogic {
    func routeToRepository(_ id: Int) -> RepoView?
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    var dataStore: HomeDataStore?

    // MARK: Routing

    func routeToRepository(_ id: Int) -> RepoView? {
        guard let repository = dataStore?.repositories.first(where: { $0.id == id }) else {
            return nil
        }
        
        return RepoConfigurator.initView(name: repository.name, fullname: repository.fullName)
    }
}
