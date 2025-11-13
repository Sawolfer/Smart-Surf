//
//  TabView.swift
//  Smart-Surf-iOS
//
//  Created by Савва Пономарев on 12.11.2025.
//

import Foundation
import SwiftUI

struct TabView: View {
    @ObservedObject var viewModel: TabViewModel

    var body: some View {
        HStack {
            Image(systemName: "globe")
            Text(viewModel.tabInfo.name)
        }
        .padding()
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .glassModifier()
        .padding(.horizontal)
    }
}
