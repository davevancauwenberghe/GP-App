//
//  SettingsViewController.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 02/08/2023.
//
//

import SwiftUI
import UIKit

// Helper to load the actual app icon
fileprivate func loadAppIcon() -> UIImage {
    if let icons = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
       let primary = icons["CFBundlePrimaryIcon"] as? [String: Any],
       let files = primary["CFBundleIconFiles"] as? [String],
       let name = files.last,
       let image = UIImage(named: name) {
        return image
    }
    return UIImage(named: "AppIcon") ?? UIImage()
}

/// SwiftUI representation of the Settings tab bar controller
struct SettingsTabView: View {
    init() {
        UITabBar.appearance().tintColor = .systemBlue
    }
    var body: some View {
        TabView {
            NavigationStack {
                SettingsView()
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.large)
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
            // Add additional tabs here if needed
        }
    }
}

/// Main SwiftUI settings list
struct SettingsView: View {
    @State private var rotate = false
    @State private var floatUp = false
    @State private var exploded = false

    var body: some View {
        List {
            headerSection

            Section("General") {
                NavigationLink(value: "notifications") {
                    Label("Push notifications", systemImage: "bell.badge.fill")
                }
            }
            Section("Appearance") {
                NavigationLink(value: "icon") {
                    Label("App icon", systemImage: "app.badge")
                }
                NavigationLink(value: "darkmode") {
                    Label("Dark mode", systemImage: "moon.fill")
                }
            }
            Section("About GP App") {
                NavigationLink(value: "story") {
                    Label("Our story", systemImage: "book.fill")
                }
                NavigationLink(value: "notes") {
                    Label("Release notes", systemImage: "doc.text.fill")
                }
                NavigationLink(value: "thankyou") {
                    Label("Thank you", systemImage: "heart.fill")
                }
                Link(destination: URL(string: "https://testflight.apple.com/join/EyTo5acT")!) {
                    Label("TestFlight", systemImage: "person.crop.circle.badge.plus")
                }
            }
            Section("Contact") {
                NavigationLink(value: "contact") {
                    Label("Let's connect", systemImage: "antenna.radiowaves.left.and.right")
                }
            }
            Section("Policies") {
                NavigationLink(value: "privacy") {
                    Label("Privacy policy", systemImage: "hand.raised.circle.fill")
                }
                NavigationLink(value: "copyright") {
                    Label("Copyright", systemImage: "doc.richtext.fill")
                }
                NavigationLink(value: "quality") {
                    Label("Photo quality", systemImage: "photo.fill")
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationDestination(for: String.self) { value in
            switch value {
            case "darkmode": DarkModeViewController()
            default: EmptyView()
            }
        }
    }

    private var headerSection: some View {
        VStack(spacing: 8) {
            Image(uiImage: loadAppIcon())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .rotationEffect(.degrees(rotate ? 45 : 0))
                .offset(y: floatUp ? -10 : 0)
                .scaleEffect(exploded ? 3 : 1)
                .opacity(exploded ? 0 : 1)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) { rotate.toggle() }
                    withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) { floatUp.toggle() }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        withAnimation(.easeInOut(duration: 0.15)) { exploded.toggle() }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                            // reset
                            exploded = false
                            floatUp = false
                            rotate = false
                        }
                    }
                }
            Text("© Dave Van Cauwenberghe - v1.7")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
    }
}
