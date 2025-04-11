//
//  ContentView.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var pageContainer = PageContainer()
    @State private var url: String = "https://www.apple.com"
    @StateObject private var webViewModel = WebViewModel()

    var body: some View {
        VStack {
            HStack {
                Button("←") {
                    webViewModel.goBack()
                }
                .padding()

                Button("→") {
                    webViewModel.goForward()
                }
                .padding()

                TextField("Enter URL", text: $url, onCommit: {
                    webViewModel.loadURL(url)
                    pageContainer.addPage(Page(url: url, name: url))
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .frame(width: 300)

                Button("Go") {
                    webViewModel.loadURL(url)
                    pageContainer.addPage(Page(url: url, name: url))
                }
                .padding()
            }

            PageContainerView(webViewModel: webViewModel)
                .environmentObject(pageContainer)

            WebView(model: webViewModel)
                .frame(minWidth: 600, minHeight: 400)
        }
    }
}
