//
//  PageViewModel.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 29.04.2025.
//

import Foundation
import SwiftUI

class PageViewModel: ObservableObject {
    @Published var page: Page
    private weak var pageContainer: PageContainer?

    var id: UUID { page.id }

    init(page: Page, container: PageContainer) {
        self.page = page
        self.pageContainer = container
    }

    func onDelete() {
        pageContainer?.removePage(id: page.id)
    }

    func getURL() -> String? {
        return page.url as? String
    }
}
