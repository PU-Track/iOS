//
//  putrackApp.swift
//  putrack
//
//  Created by 신지원 on 5/15/25.
//

import SwiftUI

@main
struct putrackApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView().tabItem { Label("Home", systemImage: "house") }
                NFCView().tabItem { Label("NFC", systemImage: "wave.3.right") }
            }
        }
    }
}
