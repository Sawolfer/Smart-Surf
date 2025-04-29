//
//  ContentViewModel.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var url: String = "https://www.apple.com"
    let pageContainer = PageContainer()
    let webViewModel = WebViewModel()

    private let urlConstants = URLConstants()

    func goBack() {
        webViewModel.goBack()
    }

    func goForward() {
        webViewModel.goForward()
    }

    func openURL() {
        guard !url.isEmpty else { return }

        let finalURL: String

        if isProperURL(url) {
            finalURL = formatDirectURL(url)
        } else {
            finalURL = createGoogleSearchURL(for: url)
        }

        webViewModel.loadURL(finalURL)

        let newPage = Page(url: finalURL, name: extractDomain(from: finalURL))
        let pageViewModel = PageViewModel(page: newPage, container: pageContainer)
        pageContainer.addPage(pageViewModel)
    }

    // Helper to check if input is a proper URL
    private func isProperURL(_ string: String) -> Bool {
        guard let url = URL(string: string) else { return false }

        // Check if it has a valid scheme and host
        let hasValidScheme = url.scheme == "http" || url.scheme == "https"
        let hasHost = url.host != nil

        // Consider it a proper URL if:
        // 1. Has http/https scheme and host (e.g., "https://apple.com")
        // OR
        // 2. Has no scheme but has dots and no spaces (e.g., "apple.com")
        return (hasValidScheme && hasHost) ||
               (string.contains(".") && !string.contains(" "))
    }

    // Format direct URLs (ensure they have https)
    private func formatDirectURL(_ urlString: String) -> String {
        if urlString.hasPrefix("http://") || urlString.hasPrefix("https://") {
            return urlString
        }
        return "https://\(urlString)"
    }

    // Create Google search URL for non-URL queries
    private func createGoogleSearchURL(for query: String) -> String {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        return "https://www.google.com/search?q=\(encodedQuery)"
    }

    // Extract domain name for display
    private func extractDomain(from urlString: String) -> String {
        guard let url = URL(string: urlString) else { return urlString }
        return url.host?.replacingOccurrences(of: "www.", with: "") ?? urlString
    }
}

struct URLConstants {
    let defaultURL = "https://www.apple.com"
    let urlPlaceholder = "Enter URL"
}
