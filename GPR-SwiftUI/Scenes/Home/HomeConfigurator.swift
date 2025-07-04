//
//  HomeConfigurator.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI
import NetworkingLayer

struct HomeConfigurator {
    static func initView() -> HomeView {
        NetworkingLayer.enableLogs()
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        router.dataStore = interactor
        let viewModel = HomeViewModel()
        var view = HomeView(viewModel: viewModel)
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.viewModel = viewModel
        return view
    }
}
