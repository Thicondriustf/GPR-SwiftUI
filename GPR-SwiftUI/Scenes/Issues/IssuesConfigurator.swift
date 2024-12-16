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
        var view = IssuesView()
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.viewModel = view.viewModel
        return view
    }
}
