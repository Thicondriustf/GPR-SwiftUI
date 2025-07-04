//
//  SettingsRow.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 04/07/2025.
//

import SwiftUI

struct SettingsRow: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.system(size: 16, weight: .bold))
            .frame(maxWidth: .infinity)
            .padding(15)
    }
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRow(title: "Title")
    }
}
