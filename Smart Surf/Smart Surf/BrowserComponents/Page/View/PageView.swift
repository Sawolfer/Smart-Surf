//
//  PageView.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.04.2025.
//

import SwiftUI

// MARK: - PageView
struct PageView: View {
    @ObservedObject var page: PageModel
    var isSelected: Bool
    var onSelect: () -> Void
    var onDelete: () -> Void

    var body: some View {
        HStack(alignment: .center) {
            Text(page.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 4)
                .font(.headline)
                .lineLimit(1)

            Button(action: onDelete) {
                Image(systemName: "x.circle")
            }
            .buttonStyle(.plain)
        }
        .contentShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .padding(.vertical, 6)
        .padding(.horizontal, 8)
        .background(isSelected ? Color.blue.opacity(0.2) : Color.clear)
        .cornerRadius(8)
        .onTapGesture {
            onSelect()
            page.webViewModel.loadURL(page.url)
        }
        .onReceive(page.webViewModel.$currentURL) { newURL in
           if isSelected {
               page.url = newURL
           }
       }
    }
}
