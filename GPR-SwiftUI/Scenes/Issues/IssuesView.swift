//
//  IssuesView.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI

struct IssuesView: View {
    var router: (IssuesRoutingLogic & IssuesDataPassing)?
    var interactor: IssuesBusinessLogic?
    @ObservedObject var viewModel = IssuesViewModel()

    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.issues) { issue in
                    IssueRow(title: issue.title, status: issue.status)
                        .listRowInsets(.none)
                }
            }
        }
            .onAppear(perform: interactor?.retrieveIssues)
            .listStyle(.plain)
            .navigationTitle("Issues " + (router?.dataStore?.week ?? ""))
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct IssuesScreen_Previews: PreviewProvider {
    static var previews: some View {
        IssuesView()
    }
}
