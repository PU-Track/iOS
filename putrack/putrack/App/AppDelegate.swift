//
//  AppDelegate.swift
//  putrack
//
//  Created by 신지원 on 5/26/25.
//

import SwiftUI

import FirebaseCore
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
      FCMManager.shared.configure(application: application)
      
    return true
  }
}

// MARK: APNs & FCM
extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        FCMManager.shared.updateAPNsToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs 디바이스 토큰 등록 실패: \(error)")
    }
}
