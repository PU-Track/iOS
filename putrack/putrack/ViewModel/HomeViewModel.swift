//
//  HomeViewModel.swift
//  putrack
//
//  Created by 신지원 on 5/17/25.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var caregiver: Caregiver = Caregiver(
        id: 0,
        name: "신지원",
        gender: .female,
        role: .caregiver,
        age: 30,
        assignedPatients: [],
        status: .working
    )

    @Published var patients: [PatientViewModel] = []

    init() {
        loadPatients()
    }

    private func loadPatients() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")

        let rawPatients = [
            Patient(
                id: 1,
                name: "홍길동",
                gender: .male,
                age: 75,
                height: 165.0,
                weight: 60.0,
                status: .bedridden,
                lastPositionChangeTime: formatter.date(from: "2025-05-17T13:00:00")!,
                nextPositionChangeTime: formatter.date(from: "2025-05-17T17:00:00")!
            ),
            Patient(
                id: 2,
                name: "이영희",
                gender: .female,
                age: 82,
                height: 150.0,
                weight: 48.0,
                status: .sitting,
                lastPositionChangeTime: formatter.date(from: "2025-05-17T13:10:00")!,
                nextPositionChangeTime: formatter.date(from: "2025-05-17T15:40:00")!
            )
        ]

        self.patients = rawPatients.map { PatientViewModel(patient: $0) }
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
