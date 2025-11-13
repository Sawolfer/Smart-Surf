//
//  BackgroundModifier.swift
//  Smart-Surf-iOS
//
//  Created by Савва Пономарев on 13.11.2025.
//

import SwiftUI

struct BackgroundImage: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.pink)
                .opacity(0.4)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .ignoresSafeArea()
    }
}

extension View {
    func backgroundModifier() -> some View {
        self
            .background(
                BackgroundImage()
            )
    }
}

// MARK: - Preview Provider
struct BackgroundPreview: PreviewProvider {

    static var previews: some View {
        BackgroundImage()
    }
}
