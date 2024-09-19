//
//  ContentView.swift
//  HATestTask
//
//  Created by Viktoryia Hermanovich on 18/09/2024.
//

import SwiftUI

struct HomeTabView: View {
    // MARK: - ViewModel
    
    @StateObject private var viewModel = HomeTabViewModel()
    
    // MARK: - Content
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            // Photo editor
            EditPhotoView()
                .tabItem {
                    Label(HomeTab.main.rawValue, systemImage: HomeTab.main.iconName)
                }
                .tag(HomeTab.main)
            
            // Settings
            SettingsView()
                .tabItem {
                    Label(HomeTab.settings.rawValue, systemImage: HomeTab.settings.iconName)
                }
                .tag(HomeTab.settings)
        }
    }
}

#Preview {
    HomeTabView()
}
