//
//  putrackApp.swift
//  putrack
//
//  Created by 신지원 on 5/15/25.
//

import SwiftUI

@main
struct putrackApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                HomeView()
                    .environmentObject(appState)
            } else {
                LoginView()
                    .environmentObject(appState)
            }
        }
    }
}
