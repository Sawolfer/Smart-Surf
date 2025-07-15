//
//  WebView.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    @ObservedObject var model: WebViewModel

    func makeNSView(context: Context) -> WKWebView {
        return model.webView
    }

    func updateNSView(_ webView: WKWebView, context: Context) { }
}
