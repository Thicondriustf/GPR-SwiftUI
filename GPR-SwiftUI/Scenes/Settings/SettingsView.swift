//
//  SettingsView.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 04/07/2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    SettingsRow(title: "Settings 1")
                        .overlay {
                            NavigationLink("") {
                                FakeView(title: "Settings 1")
                                    .navigationTitle("Settings 1")
                            }
                        }
                    SettingsRow(title: "Settings 2")
                    SettingsRow(title: "Settings 3")
                    SettingsRow(title: "Settings 4")
                }
                .listStyle(.plain)
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
