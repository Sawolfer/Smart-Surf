//
//  PageModel.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import Foundation
import SwiftUI

import Combine

class PageModel: Identifiable, ObservableObject {
    @Published var url: String
    @Published var name: String
    let id = UUID()
    @Published var webViewModel: WebViewModel

    private var observer: AnyCancellable?

    init(url: String, name: String = "Loading...") {
        self.url = url
        self.name = name
        self.webViewModel = WebViewModel()
        self.webViewModel.loadURL(url)

        setupName()
    }

    func setupName() {
        observer = webViewModel.$currentTitle
            .dropFirst()
            .sink { newTitle in
                self.name = newTitle
            }
    }
}

class PageContainer: ObservableObject {
    @Published var pages: [PageModel] = []

    func addPage(_ page: PageModel) {
        pages.append(page)
    }

    func removePage(index: UUID) {
        pages.removeAll { $0.id == index }
    }
}
