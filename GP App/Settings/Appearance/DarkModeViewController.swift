//
//  DarkModeViewController.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 04/08/2023.
//

import SwiftUI
import UIKit

/// Enumeration representing the three possible appearance modes.
enum AppearanceMode: String, CaseIterable, Identifiable {
    case system = "Use System Appearance"
    case dark = "Enable Dark mode"
    case light = "Enable Light mode"

    var id: Self { self }
}

/// SwiftUI view for selecting and applying dark/light/system appearance.
struct DarkModeViewController: View {
    // Persisted user settings
    @AppStorage("AppUsesSystemAppearance") private var useSystemAppearance: Bool = true
    @AppStorage("DarkModeEnabled") private var darkModeEnabled: Bool = false

    /// Binding that maps UserDefaults values to a single AppearanceMode.
    private var selection: Binding<AppearanceMode> {
        Binding<AppearanceMode>(
            get: {
                if useSystemAppearance {
                    return .system
                } else {
                    return darkModeEnabled ? .dark : .light
                }
            },
            set: { newValue in
                switch newValue {
                case .system:
                    useSystemAppearance = true
                    // Preserve current system style
                    let currentIsDark = UITraitCollection.current.userInterfaceStyle == .dark
                    darkModeEnabled = currentIsDark
                case .dark:
                    useSystemAppearance = false
                    darkModeEnabled = true
                case .light:
                    useSystemAppearance = false
                    darkModeEnabled = false
                }
                applyAppearance()
            }
        )
    }

    var body: some View {
        Form {
            Section {
                Picker("Appearance Mode", selection: selection) {
                    ForEach(AppearanceMode.allCases) { mode in
                        Label(mode.rawValue, systemImage: iconName(for: mode))
                            .tag(mode)
                    }
                }
                .pickerStyle(.inline)
            }
        }
        .navigationTitle("Dark mode")
        .onAppear(perform: applyAppearance)
    }

    /// Applies the selected appearance to all app windows.
    private func applyAppearance() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows.forEach { window in
            window.overrideUserInterfaceStyle = useSystemAppearance ? .unspecified : (darkModeEnabled ? .dark : .light)
        }
    }

    /// Returns the SF Symbol for each mode.
    private func iconName(for mode: AppearanceMode) -> String {
        switch mode {
        case .system: return "gear"
        case .dark:   return "moon.fill"
        case .light:  return "sun.max.fill"
        }
    }
}

struct DarkModeViewController_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DarkModeViewController()
        }
    }
}
