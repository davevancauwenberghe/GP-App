//
//  AppDelegate.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 08/07/2023.
//

import OneSignal
import UIKit

/// AppDelegate now used via UIApplicationDelegateAdaptor in SwiftUI App lifecycle
class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // OneSignal setup
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("33d6d6cc-d0f5-41fe-af21-1074df0a1450")
        OneSignal.promptForPushNotifications { accepted in
            print("User accepted notifications: \(accepted)")
        }

        // Apply saved appearance
        setupInitialAppAppearance()
        return true
    }

    private func setupInitialAppAppearance() {
        let usesSystem = UserDefaults.standard.bool(forKey: "AppUsesSystemAppearance")
        if usesSystem {
            // Follow the system appearance
            applyAppearance(style: .unspecified)
        } else {
            // Use the saved preference
            let isDark = UserDefaults.standard.bool(forKey: "DarkModeEnabled")
            applyAppearance(style: isDark ? .dark : .light)
        }
    }

    /// Applies the given user interface style to all connected scenes' windows.
    private func applyAppearance(style: UIUserInterfaceStyle) {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .forEach { $0.overrideUserInterfaceStyle = style }
    }

    // MARK: - UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
        // No action needed
    }
}
