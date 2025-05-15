//
//  HomeView.swift
//  putrack
//
//  Created by 신지원 on 5/15/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("홈입니다. 하하")
            .font(.headline)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .navigationTitle("HOME")
    }
}
