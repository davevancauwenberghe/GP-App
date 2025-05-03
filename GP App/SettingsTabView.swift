//
//  SettingsTabView.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 03/05/2025.
//

import SwiftUI

/// SwiftUI wrapper for the Settings tab
struct SettingsTabView: View {
    init() {
        // Global tint for tab bar items (if used within a TabView)
        UITabBar.appearance().tintColor = .systemBlue
    }
    
    var body: some View {
        NavigationStack {
            SettingsView()
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}
