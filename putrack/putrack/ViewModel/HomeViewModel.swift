//
//  HomeViewModel.swift
//  putrack
//
//  Created by 신지원 on 5/17/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var caregiver: Caregiver = Caregiver(
        id: 0,
        name: "신지원",
        gender: .female,
        role: .caregiver,
        age: 30,
        assignedPatients: [],
        status: .working)
    
    var roleText: String {
        switch caregiver.role {
        case .doctor: return "의사"
        case .nurse: return "간호사"
        case .nursingAssistant: return "간호조무사"
        case .caregiver: return "요양보호사"
        case .other: return "기타"
        }
    }
    
    var statusText: String {
        switch caregiver.status {
        case .working: return "근무 중"
        case .resting: return "휴식 중"
        case .offToday: return "휴무"
        }
    }
    
    var statusColor: Color {
        switch caregiver.status {
        case .working: return .green
        case .resting: return .orange
        case .offToday: return .red
        }
    }
    
    @Published var patients: [Patient] = [
        Patient(
            id: 1,
            name: "홍길동",
            gender: .male,
            age: 75,
            height: 165.0,
            weight: 60.0,
            status: .bedridden,
            lastPositionChangeTime: Date().addingTimeInterval(-3600),
            remainingTimeToNextChange: 1800
        ),
        Patient(
            id: 2,
            name: "이영희",
            gender: .female,
            age: 82,
            height: 150.0,
            weight: 48.0,
            status: .sitting,
            lastPositionChangeTime: Date().addingTimeInterval(-1800),
            remainingTimeToNextChange: 1200
        )
    ]
    
    func statusText(for status: PatientStatus) -> String {
        switch status {
        case .bedridden: return "누운 상태"
        case .sitting: return "앉은 상태"
        case .sleeping: return "수면 중"
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
    
    func formattedRemainingTime(_ interval: TimeInterval) -> (String, Color) {
        let minutes = Int(interval) / 60
        let textString = String(format: "%02d분", minutes)
        let textColor:Color = interval < 300 ? .red : .blue
        return (textString, textColor)
    }
}
