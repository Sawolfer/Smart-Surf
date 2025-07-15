//
//  WebViewModel.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import SwiftUI
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
//                self.loadURL(url, createNewPage: false)
            }
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("\(navigationAction.request.url): \(navigationAction.navigationType.rawValue)")
        if navigationAction.navigationType == .linkActivated {
            if let url = navigationAction.request.url {
                loadURL(url.absoluteString, createNewPage: false)
            }
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        guard let url = navigationAction.request.url else { return nil }
        loadURL(url.absoluteString, createNewPage: true)
        return nil
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("⚠️ Load failed: \(error.localizedDescription)")
        if (error as NSError).code == -999 {
            print("Cancelled by WebKit or delegate")
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

//https://www.google.com/url?q=https://www.ozon.ru/&sa=U&ved=2ahUKEwj0q83ax76OAxXOgSoKHYFfAU4QFnoECAMQAg&usg=AOvVaw2fgV5HDCAPDQ-GAaHgZ7ex
