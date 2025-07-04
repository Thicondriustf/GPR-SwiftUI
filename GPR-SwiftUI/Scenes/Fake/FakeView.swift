//
//  FakeView.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 04/07/2025.
//

import SwiftUI

struct FakeView: View {
    var title: String
    
    var body: some View {
        Text(title)
    }
}

struct FakeView_Previews: PreviewProvider {
    static var previews: some View {
        FakeView(title: "This is a fake view!")
    }
}
