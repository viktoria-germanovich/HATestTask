//
//  SettingsViewModel.swift
//  HATestTask
//
//  Created by Viktoryia Hermanovich on 18/09/2024.
//

import SwiftUI

// MARK: - Settings ViewModel

final class SettingsViewModel: ObservableObject {
    @Published var showAlert = false
    
    func aboutUsDidTap() {
        showAlert = true
    }
}
