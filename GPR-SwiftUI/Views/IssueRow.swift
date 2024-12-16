//
//  IssueRow.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI

struct IssueRow: View {
    var title: String
    var status: String

    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
            Spacer()
            Text(status)
                .lineLimit(1)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(15)
    }
}

struct IssueRow_Previews: PreviewProvider {
    static var previews: some View {
        IssueRow(title: "Title", status: "Status")
    }
}

