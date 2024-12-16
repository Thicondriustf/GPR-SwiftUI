//
//  RepoView.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI
import Charts

struct RepoView: View {
    var router: (RepoRoutingLogic & RepoDataPassing)?
    var interactor: RepoBusinessLogic?
    @ObservedObject var viewModel = RepoViewModel()

    @State private var isChartTapped: Bool = false
    @State private var selectedDate: Date?
    
    var body: some View {
        ZStack {
            NavigationLink(destination: router?.routeToIssues(at: selectedDate), isActive: $isChartTapped, label: { EmptyView() })
            
            if viewModel.infos.isEmpty {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity)
                    .listRowInsets(.none)
                    .listRowSeparator(.hidden)
                    .onAppear {
                        interactor?.getRepoInfos()
                        interactor?.getIssues(startDate: Date().addingTimeInterval(-7*4*24*3600))
                    }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(viewModel.infos)
                        Text("Number of issues opened in the last 28 days :")
                        Chart(viewModel.issues) { issue in
                            BarMark(x: .value("Week", issue.week, unit: .weekOfYear),
                                    y: .value("Nb issues", issue.nbIssues))
                        }
                        .chartXScale(domain: (viewModel.issues.first?.week ?? Date.now)...Date.now)
                        .chartXAxisLabel("Week", position: .bottom)
                        .chartYAxisLabel("Nb issues", position: .trailing)
                        .chartOverlay { proxy in
                            GeometryReader { geometry in
                                ZStack(alignment: .top) {
                                    Rectangle().fill(.clear).contentShape(Rectangle())
                                        .onTapGesture { location in
                                            guard let value: (Date, Int) = proxy.value(at: location) else {
                                                return
                                            }
                                            
                                            selectedDate = value.0
                                            isChartTapped = true
                                        }
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding(10)
                }
            }
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showAlert, actions: {
            Button("OK", role: .cancel, action: {})
        })
        .listStyle(.plain)
        .navigationTitle(router?.dataStore?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RepoScreen_Previews: PreviewProvider {
    static var previews: some View {
        RepoView()
    }
}

