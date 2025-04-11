//
//  PageContainerView.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import SwiftUI

struct PageContainerView: View {
    @EnvironmentObject var pageContainer: PageContainer
    @ObservedObject var webViewModel: WebViewModel

    var body: some View {
        HStack {
            ForEach(pageContainer.pages) { page in
                PageView(page: page, webViewModel: webViewModel)
            }
            .onDelete(perform: removePage)
        }
        .navigationBarBackButtonHidden(true)
    }

    func removePage(at offsets: IndexSet) {
        pageContainer.pages.remove(atOffsets: offsets)
    }
}
