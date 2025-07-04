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
    @StateObject var viewModel: RepoViewModel

    @State private var shouldNavigate: Bool = false
    @State private var selectedIssueView: IssuesView?
    
    var body: some View {
        ZStack {
            if viewModel.isLoaded {
                NavigationLink(
                    destination: selectedIssueView?.onDisappear {
                        shouldNavigate = false
                    }.id(Date().timeIntervalSince1970),
                    isActive: $shouldNavigate,
                    label: { EmptyView() }
                )
                .hidden()

                
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(viewModel.infos)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        if viewModel.hasIssues {
                            Text("Number of issues opened in the last 28 days :")
                            Chart(viewModel.issues) { issue in
                                BarMark(x: .value("Week", issue.week, unit: .weekOfYear),
                                        y: .value("Nb issues", issue.nbIssues))
                            }
                            .chartXScale(domain: (viewModel.issues.first?.week ?? Date.now)...Date.now)
                            .chartXAxisLabel("Week", position: .bottom)
                            .chartXAxis {
                                AxisMarks { value in
                                    AxisValueLabel().foregroundStyle(.blue)
                                }
                            }
                            .chartYAxisLabel("Nb issues", position: .trailing)
                            .chartYAxis {
                                AxisMarks { value in
                                    AxisValueLabel().foregroundStyle(.blue)
                                }
                            }
                            .chartOverlay { proxy in
                                GeometryReader { geometry in
                                    ZStack(alignment: .top) {
                                        Rectangle().fill(.clear).contentShape(Rectangle())
                                            .onTapGesture { location in
                                                guard let value: (Date, Int) = proxy.value(at: location),
                                                      let view = router?.routeToIssues(at: value.0) else {
                                                    return
                                                }
                                                
                                                selectedIssueView = view
                                                shouldNavigate = true
                                            }
                                    }
                                }
                            }
                        }
                    }
                    .padding(10)
                }
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity)
                    .listRowInsets(.none)
                    .listRowSeparator(.hidden)
                    .onAppear {
                        interactor?.getRepoInfos()
                        interactor?.getIssues(startDate: Date().addingTimeInterval(-7*4*24*3600))
                    }
            }
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showAlert, actions: {
            Button("OK", role: .cancel, action: {
                viewModel.showAlert = false
            })

        })
        .listStyle(.plain)
        .navigationTitle(router?.dataStore?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RepoScreen_Previews: PreviewProvider {
    static var previews: some View {
        RepoView(viewModel: RepoViewModel())
    }
}

