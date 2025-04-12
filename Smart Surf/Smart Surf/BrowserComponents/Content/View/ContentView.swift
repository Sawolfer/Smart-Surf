//
//  ContentView.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            HStack {
                Button("←") {
                    viewModel.goBack()
                }
                .padding()

                Button("→") {
                    viewModel.goForward()
                }
                .padding()

                TextField("Enter URL", text: $viewModel.url, onCommit: {
                    viewModel.openURL()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .frame(width: 300)
//TODO: move to the constants, remove go button 
                Button("Go") {
                    viewModel.openURL()
                }
                .padding()
            }

            PageContainerView(webViewModel: viewModel.webViewModel)
                .environmentObject(viewModel.pageContainer)

            WebView(model: viewModel.webViewModel)
                .frame(minWidth: 600, minHeight: 400)
        }
    }
}
