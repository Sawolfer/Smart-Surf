//
//  GlassModifier.swift
//  Smart-Surf-iOS
//
//  Created by Савва Пономарев on 13.11.2025.
//

import SwiftUI

extension View {
    func glassModifier(
        cornerRadius: CGFloat = 12
    ) -> some View {
        Group {
            if #available(iOS 26, *) {
                self
                    .glassEffect(
                        Glass.regular,
                        in: RoundedRectangle(cornerRadius: cornerRadius)
                    )
            } else {
                self
                    .background(.ultraThinMaterial)
                    .cornerRadius(cornerRadius)
            }
        }
    }
}
