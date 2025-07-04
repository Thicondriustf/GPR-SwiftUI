//
//  GPR_SwiftUIApp.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI

@main
struct GPR_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeConfigurator.initView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                NavigationStack {
                    RepoConfigurator.initView(name: "realm-swift", fullname: "realm/realm-swift")
                }
                    .tabItem {
                        Label("Other", systemImage: "list.dash")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
    }
}
