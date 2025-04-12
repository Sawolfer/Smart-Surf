//
//  ContentViewModel.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var url: String = "https://www.apple.com"
    @Published var pageContainer = PageContainer()
    @Published var webViewModel = WebViewModel()

    func goBack() {
        webViewModel.goBack()
    }

    func goForward() {
        webViewModel.goForward()
    }

    func openURL() {
        webViewModel.loadURL(url)
        let newPage = Page(url: url, name: extractDomain(from: url))
        pageContainer.addPage(newPage)
    }

    private func extractDomain(from url: String) -> String {
        return URL(string: url)?.host ?? url
    }
}
