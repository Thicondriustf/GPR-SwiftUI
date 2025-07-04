//
//  HomeView.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI

struct HomeView: View {
    var router: (HomeRoutingLogic & HomeDataPassing)?
    var interactor: HomeBusinessLogic?
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(viewModel.repositories) { repository in
                        RepositoryRow(title: repository.title, description: repository.description)
                            .listRowInsets(.none)
                            .listRowSeparator(.hidden)
                            .overlay {
                                NavigationLink("", destination: router?.routeToRepository(repository.id))
                                    .opacity(0)
                            }
                    }
                    
                    if !viewModel.isFullyLoaded {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(maxWidth: .infinity)
                            .listRowInsets(.none)
                            .listRowSeparator(.hidden)
                            .onAppear(perform: interactor?.getNextPage)
                    }

                }
            }
            .alert(viewModel.errorMessage, isPresented: $viewModel.showAlert, actions: {
                Button("OK", role: .cancel, action: {
                    viewModel.showAlert = false
                })
            })
            .listStyle(.plain)
            .navigationTitle("GitHub Public Repositories")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
