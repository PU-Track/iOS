//
//  LaunchScreenView.swift
//  putrack
//
//  Created by 신지원 on 5/30/25.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                Text("PU-TRACK")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 60)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
