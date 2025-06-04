//
//  MQTTService.swift
//  putrack
//
//  Created by 신지원 on 6/4/25.
//

import SwiftUI
import CocoaMQTT

final class MQTTService: NSObject, ObservableObject {
    private var mqtt: CocoaMQTT?
    @Published var receivedMessage: String = ""

    private let mqttHost = "d11b42071a764217bc11ec0f2f3185b5.s1.eu.hivemq.cloud"
    private let mqttPort: UInt16 = 8883
    private let mqttUsername = "putrack"
    private let mqttPassword = "Putrack1"
    private let mqttTopic = "putrack/sensor"

    override init() {
        super.init()
        setupMQTT()
    }

    private func setupMQTT() {
        let clientID = "iOSClient-\(UUID().uuidString.prefix(6))"
        mqtt = CocoaMQTT(clientID: clientID, host: mqttHost, port: mqttPort)
        mqtt?.username = mqttUsername
        mqtt?.password = mqttPassword
        mqtt?.enableSSL = true
        mqtt?.allowUntrustCACertificate = false
        mqtt?.keepAlive = 60
        mqtt?.delegate = self
        _ = mqtt?.connect()
    }

    func publish(message: String) {
        mqtt?.publish(mqttTopic, withString: message, qos: .qos1)
    }
}

extension MQTTService: CocoaMQTTDelegate {
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
            print("❌ MQTT 연결 종료됨: \(err?.localizedDescription ?? "알 수 없는 오류")")
        }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print("🧪 didConnectAck 호출됨, ack: \(ack)")
        if ack == .accept {
            print("✅ MQTT 연결 성공")
            mqtt.subscribe(mqttTopic, qos: .qos1)
        } else {
            print("❌ MQTT 연결 실패: \(ack)")
        }
    }

    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        if let payload = message.string {
            print("📨 수신됨 [\(message.topic)] → \(payload)")
            DispatchQueue.main.async {
                self.receivedMessage = payload
            }
        }
    }

    func mqtt(_ mqtt: CocoaMQTT, didDisconnectWithError error: Error?) {
        print("❌ 연결 종료: \(error?.localizedDescription ?? "알 수 없음")")
    }

    // 생략 가능한 delegate들
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {}
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {}
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {}
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {}
    func mqttDidPing(_ mqtt: CocoaMQTT) {}
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {}
}
