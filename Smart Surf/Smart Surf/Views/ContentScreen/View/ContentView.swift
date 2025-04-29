//
//  ContentView.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    private let constants = URLConstants()

    var body: some View {
        VStack {
            navigationBar
            PageContainerView()
                .environmentObject(viewModel.pageContainer)
                .environmentObject(viewModel.webViewModel)
            WebView(model: viewModel.webViewModel)
                .frame(minWidth: 600, minHeight: 400)
        }
    }

    private var navigationBar: some View {
        HStack {
            navigationButton(systemImage: "chevron.left", action: viewModel.goBack)
            navigationButton(systemImage: "chevron.right", action: viewModel.goForward)

            urlTextField
            navigationButton(systemImage: "arrow.forward", action: viewModel.openURL)
        }
        .padding()
    }

    private var urlTextField: some View {
        TextField(constants.urlPlaceholder, text: $viewModel.url) {
            viewModel.openURL()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .disableAutocorrection(true)
        .frame(width: 300)
    }

    private func navigationButton(systemImage: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .frame(width: 24, height: 24)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct WebViewModelKey: EnvironmentKey {
    static let defaultValue: WebViewModel? = nil
}

extension EnvironmentValues {
    var webViewModel: WebViewModel? {
        get { self[WebViewModelKey.self] }
        set { self[WebViewModelKey.self] = newValue }
    }
}
