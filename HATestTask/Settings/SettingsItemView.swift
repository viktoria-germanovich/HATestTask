//
//  SettingsOptionView.swift
//  HATestTask
//
//  Created by Viktoryia Hermanovich on 18/09/2024.
//

import SwiftUI

struct SettingsItemView: View {
    // MARK: - Properties
    
    var item: SettingsItem
    var onTap: () -> Void
    
    // MARK: - Content
    
    var body: some View {
        Button(
            action: onTap,
            label: {
                Text(item.rawValue)
            }
        )
    }
}

// MARK: - Settings item

enum SettingsItem: String {
    case aboutUs = "About Us"
}
