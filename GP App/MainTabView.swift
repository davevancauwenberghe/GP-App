//
//  MainTabView.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 03/05/2025.
//

import SwiftUI

struct MainTabView: View {
    init() {
        // Global tab bar appearance
        UITabBar.appearance().tintColor = .systemBlue
    }
    
    var body: some View {
        TabView {
            // Gallery tab
            NavigationStack {
                GalleryView()
            }
            .tabItem {
                Label("Gallery", systemImage: "photo.on.rectangle")
            }
            
            // Settings tab
            NavigationStack {
                SettingsTabView()
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.large)
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }
    }
}
