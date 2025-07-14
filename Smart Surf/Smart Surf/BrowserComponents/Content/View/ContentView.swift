//
//  ContentView.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject var pageContainer = PageContainer()
    @State private var urlInput: String = "https://www.apple.com"
    @State private var selectedPageID: UUID?

    @State var sideBarIsHidden: Bool = true

    var body: some View {
        ZStack {
            HStack (alignment: .top) {
                SideBar(
                    isHidden: $sideBarIsHidden,
                    pages: pageContainer,
                    selectedPageID: $selectedPageID
                )
                VStack (spacing: 4) {
                    pageNavigation
                    if let selectedPage = pageContainer.pages.first(where: { $0.id == selectedPageID }) {
                        WebView(model: selectedPage.webViewModel)
                            .frame(minWidth: 600, minHeight: 400)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal, 12)
                            .padding(.bottom, 12)
                            .id(selectedPage.id)
                            .onReceive(selectedPage.webViewModel.$currentURL) { newURL in
                                urlInput = newURL
                            }
                    } else {
                        Text("No page selected")
                            .frame(minWidth: 600, minHeight: 400)
                            .frame(maxHeight: .infinity)
                    }
                }
            }
        }
    }

    // MARK: - Subviews

    var pageNavigation: some View {
        ZStack (alignment: .center){
            HStack {
                /// sidebar button
                customButton(
                    image: "sidebar.left"
                ) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        sideBarIsHidden.toggle()
                    }
                }

                /// buttons backward and forward
                if let selectedPageID = selectedPageID,
                   let selectedPage = pageContainer.pages.first(where: { $0.id == selectedPageID }) {
                    customButton(image: "arrow.backward") {
                        selectedPage.webViewModel.goBack()
                    }
                    customButton(image: "arrow.forward") {
                        selectedPage.webViewModel.goForward()
                    }
                }

                Spacer()
            }

            /// search field
            TextField("Enter URL", text: $urlInput, onCommit: addNewPage)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .frame(width: 300)
        }
        .padding(.horizontal)
        .padding(.top, 4)
    }

    private func addNewPage() {
        let newPage = PageModel(url: urlInput)
        pageContainer.addPage(newPage)
        selectedPageID = newPage.id
    }

    func customButton(
        image: String,
        action: @escaping () -> Void
    ) -> some View {
        Image(systemName: image)
            .padding(.vertical, 9)
            .padding(.horizontal, 12)
            .onTapGesture {
                action()
            }
            .glass(cornerRadius: 12)
    }
}

// MARK: - SideBar
struct SideBar: View {
    @Binding var isHidden: Bool
    @ObservedObject var pages: PageContainer
    @Binding var selectedPageID: UUID?

    var body: some View {
        if !isHidden {
            ScrollView {
                VStack(alignment: .trailing) {
                    ForEach(pages.pages) { page in
                        pageView(page: page)
                    }
                }
                .padding()
            }
            .frame(width: 200)
            .glass(cornerRadius: 20)
        }
    }

    func pageView(page: PageModel) -> some View {
        PageView(
            page: page,
            isSelected: page.id == selectedPageID,
            onSelect: { selectedPageID = page.id },
            onDelete: { pages.removePage(index: page.id) }
        )
    }
}
