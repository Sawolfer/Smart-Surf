//
//  PageView.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import SwiftUI

struct PageView: View {
    @ObservedObject var viewModel: PageViewModel
    @ObservedObject var webViewModel: WebViewModel 

    var body: some View {
        HStack {
            Text(viewModel.getURL() ?? "No URL")
                .font(.headline)
                .lineLimit(1)
            Spacer()
            Button {
                viewModel.onDelete()
            } label: {
                Image(systemName: "multiply")
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if let url = viewModel.getURL() {
                webViewModel.loadURL(url)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}
