//
//  View+Ext.swift
//  HATestTask
//
//  Created by Viktoryia Hermanovich on 18/09/2024.
//

import SwiftUI

// MARK: - View Extensions

extension View{
    @ViewBuilder
    func frame(_ size: CGSize) -> some View {
        self
            .frame(width: size.width, height: size.height)
    }
}
