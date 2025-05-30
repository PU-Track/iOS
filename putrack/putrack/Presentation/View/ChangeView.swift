//
//  ChangeView.swift
//  putrack
//
//  Created by 신지원 on 5/31/25.
//

import SwiftUI

struct ChangeView: View {
    var status: String = "Sitting"
    @State private var selectedOption: Int? = 0
    @StateObject private var nfcViewModel = NFCViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("POSTURE CHANGE")
                .font(.largeTitle.bold())
                .padding(.horizontal)
            
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 2)
                .padding(.horizontal)
                .padding(.bottom, 10)
            
            Text("NOW: \(status)")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            Text("Choose the next posture or review previous data.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            // Sitting 버튼
            Button(action: {
                selectedOption = 0
            }) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        selectedOption == 0 ?
                        LinearGradient(
                            gradient: Gradient(colors: [Color.lightCoral, Color.deepCoral]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ) :
                            LinearGradient(
                                gradient: Gradient(colors: [Color.gray.opacity(0.2), Color.gray.opacity(0.6)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                    )
                    .frame(height: 200)
                    .overlay(
                        VStack {
                            HStack {
                                Text("SITTING")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.leading, 40)
                            .padding(.top, 60)
                            
                            Spacer()
                            
                            HStack {
                                Spacer()
                                Image(systemName: "figure.roll")
                                    .font(.system(size: 100))
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .padding(.trailing, 40)
                            .padding(.bottom, 60)
                        }
                    )
            }
            .padding(.horizontal)
            
            // lying, sleeping 버튼
            HStack(spacing: 10) {
                Button(action: {
                    selectedOption = 1
                }) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            selectedOption == 1 ?
                            LinearGradient(
                                gradient: Gradient(colors: [Color.deepCoral, Color.lightCoral]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ) :
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.gray.opacity(0.6), Color.gray.opacity(0.2)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                        )
                        .frame(width: 150, height: 100)
                        .overlay(
                            VStack(spacing: 4) {
                                Image(systemName: "bed.double.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white.opacity(0.8))
                                Text("LYING")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        )
                }
                
                Button(action: {
                    selectedOption = 2
                }) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            selectedOption == 2 ?
                            LinearGradient(
                                gradient: Gradient(colors: [Color.lightCoral, Color.deepCoral]),
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            ) :
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.gray.opacity(0.2), Color.gray.opacity(0.6)]),
                                    startPoint: .bottomLeading,
                                    endPoint: .topTrailing
                                )
                        )
                        .frame(width: 150, height: 100)
                        .overlay(
                            VStack(spacing: 4) {
                                Image(systemName: "moon.zzz.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white.opacity(0.8))
                                Text("SLEEPING")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        )
                }
            }
            .padding(.bottom, 10)
            
            Button("TAGGING") {
                nfcViewModel.startScanning()
            }
            .padding()
            .background(Color.middleBlue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(.top, 20)
            
            Spacer()
        }
        .padding(.horizontal, 30)
    }
}
