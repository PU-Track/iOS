//
//  FCMManager.swift
//  putrack
//
//  Created by 신지원 on 5/26/25.
//

import SwiftUI

import FirebaseCore
import FirebaseMessaging
import UserNotifications

class FCMManager: NSObject, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    static let shared = FCMManager(service: CaregiverService())
    private let service: CaregiverService
    
    init(service: CaregiverService) {
        self.service = service
        super.init()
    }
    
    // FireBase 초기 설정
    func configure(application: UIApplication) {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        requestNotificationAuthorization()
        
        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()
    }
    
    // 알람권한 요청
    private func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
                    if let error = error { print("\(error.localizedDescription)") }
                    print("\(granted)")
                }
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    // APNs Token 업데이트
    func updateAPNsToken(_ deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        print("APNs 디바이스 토큰 등록 성공: \(deviceToken)")
    }
    
    // FCM Token 업데이트
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let token = fcmToken else { return }
        
        let savedToken = UserDefaults.standard.string(forKey: "fcmToken")
        if token != savedToken {
            UserDefaults.standard.set(token, forKey: "fcmToken")
            print("✅ FCM 토큰 업데이트: \(token)")
        }
        
        guard let token = fcmToken, token != UserDefaults.standard.string(forKey: "fcmToken") else { return }
        
        UserDefaults.standard.set(token, forKey: "fcmToken")
        print("Firebase token updated: \(token)")
    }
}

// MARK: FCM 서버 연결

extension FCMManager {
    func sendFCMToken(code: String, token: String) async throws {
        print("code: \(code)\n")
        print("token: \(token)\n")
        do {
            try await service.postRegisterDeviceToken(code: code,
                                                      deviceData: FCMTokenRequest(
                                                        pushToken: token))
        } catch {
            print("Failed to post device token: \(error.localizedDescription)")
            throw error
        }
    }
}
