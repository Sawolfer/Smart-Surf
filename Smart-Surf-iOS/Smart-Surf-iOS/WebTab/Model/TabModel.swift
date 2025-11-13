//
//  TabModel.swift
//  Smart-Surf-iOS
//
//  Created by Савва Пономарев on 12.11.2025.
//

import Foundation
import SwiftData

@Model
class TabModel {
    var id: UUID
    var name: String
    var url: String

    init(id: UUID?, name: String?, url: String) {
        self.id = id ?? UUID()
        self.name = name ?? url
        self.url = url
    }
}
