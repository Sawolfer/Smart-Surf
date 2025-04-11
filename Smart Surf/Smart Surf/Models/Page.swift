//
//  Page.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import Foundation
import SwiftUI

class Page: Identifiable, ObservableObject {
    var url: String
    var name: String
    let id = UUID()

    init() {
        self.name = "new page"
        self.url = "https://www.google.com"
    }

    init(url: String, name: String) {
        self.url = url
        self.name = name
    }
}

class PageContainer: ObservableObject {
    @Published var pages: [Page] = []

    func addPage(_ page: Page) {
        pages.append(page)
    }

    func removePage(index: UUID) {
        pages.removeAll { $0.id == index }
    }
}
