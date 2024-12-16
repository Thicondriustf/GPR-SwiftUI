//
//  GPR_SwiftUIApp.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI

@main
struct GPR_SwiftUIApp: App {
    @ObservedObject var navigator = AppNavigator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigator.navPath) {
                HomeConfigurator.initView()
            }
            .environmentObject(navigator)
        }
    }
}
