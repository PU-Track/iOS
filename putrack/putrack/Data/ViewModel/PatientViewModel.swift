//
//  PatientViewModel.swift
//  putrack
//
//  Created by 신지원 on 5/17/25.
//

import Foundation
import SwiftUI
import Combine

final class PatientViewModel: ObservableObject {
    let patient: Patient
    private var timer: AnyCancellable?
    
    @Published var elapsedSinceLastChange: TimeInterval = 0
    @Published var currentRemainingTime: TimeInterval = 0
    
    //MARK: 타이머 로직
    init(patient: Patient) {
        self.patient = patient
        updateTime()
        startTimer()
    }
    
    deinit {
        timer?.cancel()
    }
    
    private func updateTime() {
        let now = Date()
        let elapsed = now.timeIntervalSince(patient.lastPositionChangeTime)
        let remaining = patient.nextPositionChangeTime.timeIntervalSince(now)

        elapsedSinceLastChange = max(0, elapsed)
        currentRemainingTime = remaining
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTime()
            }
    }
    
    // MARK: 타이머 데이터 처리
    var formattedElapsedTime: String {
        let hours = Int(elapsedSinceLastChange) / 3600
        let minutes = (Int(elapsedSinceLastChange) % 3600) / 60
        return String(format: "%02d시간 %02d분", hours, minutes)
    }
    
    var formattedElapsedTimeWithSecond: String {
        let hours = Int(elapsedSinceLastChange) / 3600
        let minutes = (Int(elapsedSinceLastChange) % 3600) / 60
        let seconds = Int(elapsedSinceLastChange) % 60
        return String(format: "%02d시간 %02d분 %02d초", hours, minutes, seconds)
    }
    
    var formattedRemainingTime: String {
        let isOverdue = currentRemainingTime < 0
        let hours = abs(Int(currentRemainingTime)) / 3600
        let minutes = abs(Int(currentRemainingTime) % 3600) / 60
        let prefix = isOverdue ? "+" : ""
        return String(format: "%@%02d시간 %02d분", prefix, hours, minutes)
    }

    var formattedRemainingTimeWithSecond: String {
        let isOverdue = currentRemainingTime < 0
        let hours = abs(Int(currentRemainingTime)) / 3600
        let minutes = abs(Int(currentRemainingTime) % 3600) / 60
        let seconds = abs(Int(currentRemainingTime)) % 60
        let prefix = isOverdue ? "+" : ""
        return String(format: "%@%02d시간 %02d분 %02d초", prefix, hours, minutes, seconds)
    }
    
    var formattedLastChangeTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH시 mm분"
        return formatter.string(from: patient.lastPositionChangeTime)
    }
    
    var formattedLastChangeTimeWithDetail: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH시 mm분 ss초"
        return formatter.string(from: patient.lastPositionChangeTime)
    }
    
    var remainingTimeColor: Color {
        currentRemainingTime < 300 ? .red : .blue
    }
    
    // MARK: 정적 데이터 처리
    var genderText: String {
        switch patient.gender {
        case .male: return "남성"
        case .female: return "여성"
        }
    }
    
    var genderShortText: String {
        switch patient.gender {
        case .male: return "남"
        case .female: return "여"
        }
    }
    
    var statusText: String {
        switch patient.status {
        case .bedridden: return "누운 상태"
        case .sitting: return "앉은 상태"
        case .sleeping: return "수면 중"
        }
    }
}
