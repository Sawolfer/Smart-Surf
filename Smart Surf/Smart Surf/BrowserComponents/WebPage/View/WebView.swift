//
//  WebView.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable{
    @ObservedObject var model: WebViewModel

    var delegate: WKUIDelegate?

    func makeNSView(context: Context) -> WKWebView {
        if let delegate { model.webView.uiDelegate = delegate }
        return model.webView
    }

    func updateNSView(_ webView: WKWebView, context: Context) {
    }
}
