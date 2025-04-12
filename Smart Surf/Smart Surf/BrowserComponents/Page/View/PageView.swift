//
//  PageView.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import SwiftUI

struct PageView: View {
    @StateObject var page: Page
    @EnvironmentObject var pageContainer: PageContainer
    @ObservedObject var webViewModel: WebViewModel

    var body: some View {
        HStack {
            Text(webViewModel.getTitle())
                .font(.headline)
            Spacer()
            Button("X") {
                pageContainer.removePage(index: page.id)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            webViewModel.loadURL(page.url)
        }
    }
}
