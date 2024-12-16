//
//  RepoConfigurator.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI

struct RepoConfigurator {
    static func initView() -> RepoView {
        let interactor = RepoInteractor()
        let presenter = RepoPresenter()
        let router = RepoRouter()
        router.dataStore = interactor
        var view = RepoView()
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.viewModel = view.viewModel
        return view
    }
}
