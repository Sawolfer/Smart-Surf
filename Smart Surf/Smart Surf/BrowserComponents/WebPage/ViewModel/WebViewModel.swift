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

    override init() {
        super.init()
        webView.navigationDelegate = self
    }

    func loadURL(_ url: String) {
        var validURL: String

        if isValidURL(url) {
            webView.load(URLRequest(url: URL(string: url)!))
        } else {
            let query = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            validURL = "https://www.google.com/search?q=\(query)"
            if let requestURL = URL(string: validURL) {
                webView.load(URLRequest(url: requestURL))
            }
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
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.currentTitle = webView.title ?? ""
        self.currentURL = webView.url?.absoluteString ?? ""
    }
}
