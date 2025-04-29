//
//  Page.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import Foundation


class Page: Identifiable, ObservableObject {
    @Published var url: String
    @Published var name: String
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
