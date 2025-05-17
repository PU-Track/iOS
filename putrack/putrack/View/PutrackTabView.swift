//
//  PutrackTabView.swift
//  putrack
//
//  Created by 신지원 on 5/17/25.
//

import SwiftUI

struct PutrackTabView: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                Label("Home", systemImage: "house")
            }
            NFCView().tabItem {
                Label("NFC", systemImage: "wave.3.right")
            }
        }
    }
}
