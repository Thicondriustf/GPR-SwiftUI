//
//  RepoConfigurator.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI

struct RepoConfigurator {
    static func initView(name: String, fullname: String) -> RepoView {
        let interactor = RepoInteractor()
        interactor.name = name
        interactor.fullName = fullname
        let presenter = RepoPresenter()
        let router = RepoRouter()
        router.dataStore = interactor
        let viewModel = RepoViewModel()
        var view = RepoView(viewModel: viewModel)
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.viewModel = viewModel
        return view
    }
}
