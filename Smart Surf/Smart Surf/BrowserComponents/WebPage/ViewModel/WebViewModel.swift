//
//  WebViewModel.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import WebKit

class WebViewModel: NSObject, ObservableObject {
    @Published var currentTitle: String = ""
    @Published var currentURL: String = ""
    let webView = WKWebView()
    var shouldCreateNewPageOnNavigation = false

    override init() {
        super.init()
        webView.navigationDelegate = self
    }

    func loadURL(_ url: String, createNewPage: Bool = false) {
        shouldCreateNewPageOnNavigation = createNewPage
        currentURL = url

        if isValidURL(url) {
            webView.load(URLRequest(url: URL(string: url)!))
        } else {
            let query = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let validURL = "https://www.google.com/search?q=\(query)"
            webView.load(URLRequest(url: URL(string: validURL)!))
        }
    }

    func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }

    func getTitle() -> String {
        return webView.title ?? ""
    }

    private func isValidURL(_ string: String) -> Bool {
        return string.hasPrefix("http://") || string.hasPrefix("https://")
    }
}

extension WebViewModel: WKNavigationDelegate {
    // WKNavigationDelegate method
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        DispatchQueue.main.async {
            if let url = webView.url?.absoluteString, url != self.currentURL {
                self.currentURL = url
                if self.shouldCreateNewPageOnNavigation {
                    self.shouldCreateNewPageOnNavigation = false
                    NotificationCenter.default.post(name: .createNewPage, object: url)
                }
            }
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.currentTitle = webView.title ?? self.currentURL
    }
}

// MARK: - Notification Extension
extension Notification.Name {
    static let createNewPage = Notification.Name("createNewPage")
}
