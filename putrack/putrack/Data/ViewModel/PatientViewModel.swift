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
    @Published var patient: Patient
    private var timer: AnyCancellable?
    private var firebaseCancellables = Set<AnyCancellable>()
    
    @Published var elapsedSinceLastChange: TimeInterval = 0
    @Published var currentRemainingTime: TimeInterval = 0
    
    @ObservedObject private var sensorService = FirebaseService()
    
    init(patient: Patient) {
        self.patient = patient
        
        observeSensorData()
        updateTime()
        startTimer()
    }
    
    deinit {
        timer?.cancel()
        sensorService.stopObserving()
    }
    
    private func observeSensorData() {
        // Realtime Firebase 관찰 시작
        sensorService.$airTemperature
            .receive(on: RunLoop.main)
            .sink { [weak self] newTemp in
                self?.patient.temperature = Float(newTemp)
            }
            .store(in: &firebaseCancellables)
        
        sensorService.$airHumidity
            .receive(on: RunLoop.main)
            .sink { [weak self] newHumid in
                self?.patient.humidity = Float(newHumid)
            }
            .store(in: &firebaseCancellables)
        
        sensorService.$cushionTemperature
            .receive(on: RunLoop.main)
            .sink { [weak self] newCushionTemp in
                self?.patient.sittingTemperature = Float(newCushionTemp)
            }
            .store(in: &firebaseCancellables)
    }
    
    var airTemperatureText: String {
        String(format: "%.1f°C", sensorService.airTemperature)
    }
    
    var airHumidityText: String {
        String(format: "%.1f°C", sensorService.airHumidity)
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
    
    func updatePatientData(status: PostureStatus, startTime: String, nextTime: String) {
        guard let parsedStart = kstFormatter.date(from: startTime),
              let parsedNext = kstFormatter.date(from: nextTime) else {
            print("❌ 날짜 파싱 실패. start: \(startTime), next: \(nextTime)")
            return
        }
        
        var updated = patient
        updated.status = status
        updated.lastPositionChangeTime = parsedStart
        updated.nextPositionChangeTime = parsedNext
        
        self.patient = updated
        updateTime()
        
        print("✅ 파싱 성공: start = \(parsedStart), next = \(parsedNext)")
    }
    
    private let kstFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    // MARK: 타이머 포맷 출력
    var formattedElapsedTimeWithSecond: String {
        let hours = Int(elapsedSinceLastChange) / 3600
        let minutes = (Int(elapsedSinceLastChange) % 3600) / 60
        let seconds = Int(elapsedSinceLastChange) % 60
        return String(format: "%02d시간 %02d분 %02d초", hours, minutes, seconds)
    }
    
    var formattedRemainingTimeWithSecond: String {
        let isOverdue = currentRemainingTime < 0
        let hours = abs(Int(currentRemainingTime)) / 3600
        let minutes = abs(Int(currentRemainingTime) % 3600) / 60
        let seconds = abs(Int(currentRemainingTime)) % 60
        let prefix = isOverdue ? "+" : ""
        return String(format: "%@%02d시간 %02d분 %02d초", prefix, hours, minutes, seconds)
    }
    
    var formattedElapsedTime: String {
        let hours = Int(elapsedSinceLastChange) / 3600
        let minutes = (Int(elapsedSinceLastChange) % 3600) / 60
        return String(format: "%02d시간 %02d분", hours, minutes)
    }
    
    var formattedRemainingTime: String {
        let isOverdue = currentRemainingTime < 0
        let hours = abs(Int(currentRemainingTime)) / 3600
        let minutes = abs(Int(currentRemainingTime) % 3600) / 60
        let prefix = isOverdue ? "+" : ""
        return String(format: "%@%02d시간 %02d분", prefix, hours, minutes)
    }
    
    var formattedLastChangeTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 HH시 mm분"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter.string(from: patient.lastPositionChangeTime)
    }
    
    var formattedLastChangeTimeWithDetail: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 HH시 mm분 ss초"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter.string(from: patient.lastPositionChangeTime)
    }
    
    var remainingTimeColor: Color {
        currentRemainingTime < 300 ? .red : .blue
    }
    
    // MARK: 정적 텍스트들
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
        case .lying: return "누운 상태"
        case .sitting: return "앉은 상태"
        case .sleeping: return "수면 중"
        }
    }
    
    var statusTextWithEnglish: String {
        switch patient.status {
        case .lying: return "LYING"
        case .sitting: return "SITTING"
        case .sleeping: return "SLEEPING"
        }
    }
    
    func setSelectedStatus(selectedOption: Int) -> PostureStatus {
        switch selectedOption {
        case 0: return .sitting
        case 1: return .lying
        case 2: return .sleeping
        default: return .sitting
        }
    }
}
