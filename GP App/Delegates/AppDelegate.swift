//
//  AppDelegate.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 08/07/2023.
//

import OneSignal
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)

        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("33d6d6cc-d0f5-41fe-af21-1074df0a1450")

        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })

        setupInitialAppAppearance()

        return true
    }

    func setupInitialAppAppearance() {
        let usesSystemAppearance = UserDefaults.standard.bool(forKey: "AppUsesSystemAppearance")

        if usesSystemAppearance {
            // Follow the system's appearance setting
            if #available(iOS 13.0, *) {
                window?.overrideUserInterfaceStyle = .unspecified
            }
        } else {
            // Use the saved preference
            let isDarkModeEnabled = UserDefaults.standard.bool(forKey: "DarkModeEnabled")
            setAppWideMode(isDarkModeEnabled)
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
    }

    func setAppWideMode(_ isDarkModeEnabled: Bool) {
        if isDarkModeEnabled {
            applyDarkMode()
        } else {
            applyLightMode()
        }
    }

    private func applyDarkMode() {
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                for window in windowScene.windows {
                    window.overrideUserInterfaceStyle = .dark
                }
            }
        }
    }

    private func applyLightMode() {
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                for window in windowScene.windows {
                    window.overrideUserInterfaceStyle = .light
                }
            }
        }
    }
}
