//
//  PageContainerView.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import SwiftUI

struct PageContainerView: View {
    @EnvironmentObject var pageContainer: PageContainer
    @EnvironmentObject var webViewModel: WebViewModel

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(pageContainer.pages, id: \.id) { pageVm in
                    PageView(
                        viewModel: pageVm,
                        webViewModel: webViewModel 
                    )
                }
            }
            .padding()
        }
    }
}
