//
//  IssuesConfigurator.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI

struct IssuesConfigurator {
    static func initView() -> IssuesView {
        let interactor = IssuesInteractor()
        let presenter = IssuesPresenter()
        let router = IssuesRouter()
        router.dataStore = interactor
        let viewModel = IssuesViewModel()
        var view = IssuesView(viewModel: viewModel)
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.viewModel = viewModel
        return view
    }
}
