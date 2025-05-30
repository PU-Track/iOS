//
//  RootView.swift
//  putrack
//
//  Created by 신지원 on 5/30/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    @State private var showLaunchScreen = true
    
    var body: some View {
        Group {
            HomeView(userCode: appState.userCode ?? "")
//            if showLaunchScreen {
//                LaunchScreenView()
//                    .transition(.opacity)
//                    .ignoresSafeArea()
//            } else {
//                if appState.isLoggedIn {
//                    HomeView(userCode: appState.userCode ?? "")
//                } else {
//                    LoginView()
//                }
//            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showLaunchScreen = false
                }
            }
        }
    }
}
