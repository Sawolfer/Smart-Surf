//
//  summarize.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 16.02.2025.
//

import Foundation
import WebKit


// https://en-US.wikipedia.org/wiki/%D0%9E%D0%BF%D0%BE%D1%81%D1%81%D1%83%D0%BC%D0%BE%D0%B2%D1%8B%D0%B5

class WebViewLoader: NSObject, WKNavigationDelegate {
    var webView: WKWebView?
    var resultHandler: ((String) -> Void)?
    
    let summarize: TextSummarizer
    
    override init() {
        let config = WKWebViewConfiguration()
        summarize = TextSummarizer()
    
        self.webView = WKWebView(frame: .zero, configuration: config)
        super.init()
        self.webView!.navigationDelegate = self
    }
    
    func makeRequest(url: String) {
        guard let validURL = URL(string: url) else {
            print("Invalid URL")
            resultHandler?("Invalid URL")
            return
        }
        
        print("start search")
        webView?.load(URLRequest(url: validURL))
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        print("start load")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("page loaded")
        webView.evaluateJavaScript("""
            (function() {
                function removeElements(selectors) {
                    selectors.forEach(selector => {
                        document.querySelectorAll(selector).forEach(el => el.remove());
                    });
                }

                // Common ad, navigation, and sidebar selectors
                removeElements([
                    'nav', 'header', 'footer', 'aside',  // Navigation & Sidebars
                    '.ads', '.advertisement', '[id*="ad"]', '[class*="ad"]',  // Ads
                    '.popup', '.newsletter', '.related-articles' // Other distractions
                ]);

                // Extract main content (prioritize <article>, fallback to body)
                let content = document.querySelector('article') || document.body;
                return content.innerText;
            })();
        """) { (result, error) in
            if let content = result as? String {
                print("Cleaned Content:\n\(content)")
                let summary = content.split(separator: "\n").prefix(10).joined(separator: "\n")
                print("----------SUMMARY----------")
                print(summary)
                print("---------------------------\n")
            } else if let error = error {
                print("Error extracting content: \(error)")
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Load failed: \(error.localizedDescription)")
        resultHandler?("Load error: \(error.localizedDescription)")
    }
}
