//
//  GPApp.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 03/05/2025.
//

import SwiftUI

@main
struct GPApp: App {
    // Integrate AppDelegate for OneSignal and appearance setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
