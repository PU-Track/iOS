//
//  HomeViewModel.swift
//  putrack
//
//  Created by 신지원 on 5/17/25.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var caregiver: Caregiver
    @Published var patients: [PatientViewModel] = []
    
    init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        let rawPatients = [
            Patient(
                id: 1,
                name: "쿠로미",
                gender: .female,
                age: 80,
                height: 150.0,
                weight: 47.0,
                status: .bedridden,
                lastPositionChangeTime: formatter.date(from: "2025-05-19T11:50:00")!,
                nextPositionChangeTime: formatter.date(from: "2025-05-19T13:00:00")!
            ),
            Patient(
                id: 2,
                name: "마이멜로디",
                gender: .male,
                age: 82,
                height: 150.0,
                weight: 48.0,
                status: .sitting,
                lastPositionChangeTime: formatter.date(from: "2025-05-19T12:10:00")!,
                nextPositionChangeTime: formatter.date(from: "2025-05-19T15:40:00")!
            ),
            Patient(
                id: 3,
                name: "폼폼푸린",
                gender: .male,
                age: 78,
                height: 165.0,
                weight: 60.0,
                status: .bedridden,
                lastPositionChangeTime: formatter.date(from: "2025-05-19T12:00:00")!,
                nextPositionChangeTime: formatter.date(from: "2025-05-19T14:30:00")!
            ),
            Patient(
                id: 4,
                name: "헬로키티",
                gender: .female,
                age: 75,
                height: 155.0,
                weight: 52.0,
                status: .sitting,
                lastPositionChangeTime: formatter.date(from: "2025-05-19T11:00:00")!,
                nextPositionChangeTime: formatter.date(from: "2025-05-19T15:00:00")!
            ),
            Patient(
                id: 5,
                name: "리틀트윈스",
                gender: .male,
                age: 85,
                height: 160.0,
                weight: 65.0,
                status: .bedridden,
                lastPositionChangeTime: formatter.date(from: "2025-05-19T10:00:00")!,
                nextPositionChangeTime: formatter.date(from: "2025-05-19T10:40:00")!
            )
        ]
        
        self.patients = rawPatients.map { PatientViewModel(patient: $0) }
        
        self.caregiver = Caregiver(
            id: 0,
            name: "신지원",
            gender: .female,
            role: .caregiver,
            age: 30,
            assignedPatients: rawPatients,
            status: .working
        )
    }
    
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
}
