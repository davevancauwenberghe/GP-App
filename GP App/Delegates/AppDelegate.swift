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
    var window: UIWindow?

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
            if #available(iOS 13.0, *) {
                window?.overrideUserInterfaceStyle = .unspecified
            }
        } else {
            let isDark = UserDefaults.standard.bool(forKey: "DarkModeEnabled")
            setAppWideMode(isDark)
        }
    }

    // MARK: - Appearance Helpers
    func setAppWideMode(_ dark: Bool) {
        if #available(iOS 13.0, *) {
            let style: UIUserInterfaceStyle = dark ? .dark : .light
            UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .forEach { $0.overrideUserInterfaceStyle = style }
        }
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
