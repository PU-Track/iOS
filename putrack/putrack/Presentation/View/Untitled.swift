//
//  Untitled.swift
//  putrack
//
//  Created by 신지원 on 6/4/25.
//

import SwiftUI

struct MQTTTestView: View {
    @StateObject private var mqttService = MQTTService()
    @State private var message = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("📡 MQTT 테스트").font(.title2).bold()

            Text("수신 메시지:")
            Text(mqttService.receivedMessage)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            TextField("보낼 메시지", text: $message)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("📤 발행") {
                mqttService.publish(message: message)
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear {
            print("📲 MQTTTestView 나타남")
        }
        .padding()
    }
}
