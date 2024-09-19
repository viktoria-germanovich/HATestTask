//
//  SettingsView.swift
//  HATestTask
//
//  Created by Viktoryia Hermanovich on 18/09/2024.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - ViewModel
    
    @StateObject private var viewModel = SettingsViewModel()
    
    // MARK: - Content
    
    var body: some View {
        NavigationStack {
            List {
                SettingsItemView(item: .aboutUs, onTap: viewModel.aboutUsDidTap)
            }
            .alert(Const.alertMessage, isPresented: $viewModel.showAlert) {
                Button(Const.okButton, role: .cancel) { }
            }
            .navigationTitle(Const.screenTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

// MARK: - Constants

private extension SettingsView {
    enum Const {
        static let screenTitle = "Settings"
        static let alertMessage = "Viktoryia Hermaonvich"
        static let okButton = "OK"
    }
}

#Preview {
    SettingsView()
}
