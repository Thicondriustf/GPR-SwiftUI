//
//  RepositoryRow.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import SwiftUI

struct RepositoryRow: View {
    var title: String
    var description: String

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .bold))
                Text(description)
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .medium))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: "arrow.forward")
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: .black, radius: 3)
                .opacity(0.2)
            )
    }
}

struct RepositoryRow_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryRow(title: "Title", description: "Description")
    }
}
