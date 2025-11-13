//
//  ContentView.swift
//  Smart-Surf-iOS
//
//  Created by Савва Пономарев on 12.11.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var tabs: [TabModel] = [TabModel]()

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    ForEach(tabs, id: \.id) { tab in
                        TabView(viewModel: TabViewModel(tabInfo: tab))
                    }
                }
                .navigationTitle("Tabs")

                buttonAddNew
                    .frame(
                        maxWidth: .infinity,
                        alignment: .bottomTrailing
                    )
                    .padding()
            }
            .frame(
                maxWidth: .infinity
            )
            .backgroundModifier()
        }
    }

    var buttonAddNew: some View {
        Button {
            tabs.append(
                TabModel(
                    id: UUID(),
                    name: "apple",
                    url: "https://www.apple.com/"
                )
            )
        } label: {
            Image(systemName: "plus")
        }
        .padding()
        .glassModifier(cornerRadius: 50)
    }

    private func deleteTab(at offsets: IndexSet) {
        tabs.remove(atOffsets: offsets)
    }

}

// MARK: - Preview
struct ContentViewPreview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
