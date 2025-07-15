//
//  WebPageRemakeView.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 15.07.2025.
//

import Foundation
import SwiftUI
import WebKit

struct WKWebViewRepresentable: NSViewRepresentable {
    typealias NSViewType = WKWebView

    @Binding var url: URL
    private let webView: WKWebView
    private let onLinkActivation: ((URL) -> Void)?

    init(url: Binding<URL>,
         webView: WKWebView = WKWebView(),
         onLinkActivation: ((URL) -> Void)? = nil) {
        self._url = url
        self.webView = webView
        self.onLinkActivation = onLinkActivation
    }

    func makeNSView(context: Context) -> WKWebView {
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator

        // Load initial URL if needed
        if webView.url == nil || webView.url != url {
            webView.load(URLRequest(url: url))
        }

        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        // Only load if the URL is different from current
        if nsView.url != url {
            nsView.load(URLRequest(url: url))
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        private var parent: WKWebViewRepresentable

        init(parent: WKWebViewRepresentable) {
            self.parent = parent
        }

        // MARK: - WKNavigationDelegate

        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            DispatchQueue.main.async {
                if let url = webView.url {
                    self.parent.onLinkActivation?(url)
                }
            }
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.cancel)
                return
            }

            // Handle link activations
            if navigationAction.navigationType == .linkActivated {
                if navigationAction.targetFrame?.isMainFrame == true {
                    parent.onLinkActivation?(url)
                    decisionHandler(.cancel)
                    return
                }
            }

            decisionHandler(.allow)
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                if let url = webView.url, self.parent.url != url {
                    self.parent.url = url
                }
            }
        }

        // MARK: - WKUIDelegate

        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if let url = navigationAction.request.url {
                parent.onLinkActivation?(url)
            }
            return nil
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("WebView navigation failed: \(error.localizedDescription)")
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("WebView provisional navigation failed: \(error.localizedDescription)")
        }
    }
}
