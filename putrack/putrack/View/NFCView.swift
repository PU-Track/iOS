//
//  NFCView.swift
//  putrack
//
//  Created by 신지원 on 5/15/25.
//

import SwiftUI

struct NFCView: View {
    @StateObject private var viewModel = NFCViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Button("Scan NFC Tag") {
                viewModel.startScanning()
            }
            .font(.headline)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())

            Text(viewModel.lastScannedText)
                .padding()
                .multilineTextAlignment(.center)
        }
        .navigationTitle("NFC Scan")
    }
}

//#Preview {
//    NFCViewView()
//}
