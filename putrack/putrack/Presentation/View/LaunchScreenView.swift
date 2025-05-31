//
//  LaunchScreenView.swift
//  putrack
//
//  Created by 신지원 on 5/30/25.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color.deepBlue
                .ignoresSafeArea()
            
            Image(.logoWithName)
                .resizable()
                .frame(width: 280, height: 142)
        }
    }
}
