//
//  SmartBrowserApp.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import SwiftUI

@main
struct SimpleBrowserApp: App {
    @StateObject var pageContainer = PageContainer()
    @StateObject var webViewModel = WebViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pageContainer)
                .environmentObject(webViewModel)
        }
    }
}
