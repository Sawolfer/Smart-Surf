//
//  TabViewModel.swift
//  Smart-Surf-iOS
//
//  Created by Савва Пономарев on 12.11.2025.
//

import Foundation
import SwiftUI
import Combine

final class TabViewModel: ObservableObject {
    var tabInfo: TabModel

    init(tabInfo: TabModel) {
        self.tabInfo = tabInfo
    }
}
