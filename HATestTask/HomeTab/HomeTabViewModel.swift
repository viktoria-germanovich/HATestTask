//
//  HomeTab.swift
//  HATestTask
//
//  Created by Viktoryia Hermanovich on 18/09/2024.
//

import SwiftUI

// MARK: - HomeTab ViewModel

final class HomeTabViewModel: ObservableObject {
    @Published var selectedTab: HomeTab = .main
}

// MARK: - Tabs

enum HomeTab: String {
    case main = "Main"
    case settings = "Settings"
    
    var iconName: String {
        switch self {
        case .main:
            "house"
            
        case .settings:
            "gearshape.fill"
        }
    }
}
