//
//  PageContainer.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 29.04.2025.
//

import Foundation

class PageContainer: ObservableObject {
    @Published var pages: [PageViewModel] = []

    func addPage(_ page: PageViewModel) {
        if !pages.contains(where: { $0.id == page.id }) {
            pages.append(page)
        }
    }

    func removePage(id: UUID) {
        pages.removeAll { $0.id == id }
    }
}
