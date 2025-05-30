//
//  CaregiverModel.swift
//  putrack
//
//  Created by 신지원 on 5/17/25.
//

struct Caregiver {
    let name: String
    let gender: Gender
    let role: CaregiverRole
    let age: Int
    let assignedPatients: Int
    let status: CaregiverStatus
}
extension CaregiverResponse {
    func toEntity() -> Caregiver {
        return Caregiver(
            name: self.name,
            gender: self.gender,
            role: self.role,
            age: self.age,
            assignedPatients: 4,
            status: .working)
    }
}

enum CaregiverStatus {
    case working
    case resting
    case offToday
}

enum CaregiverRole: String, Codable {
    case caregiver = "CAREGIVER"
    case doctor = "DOCTOR"
    case nurse = "NURSE"
    case nursingAssistant = "NURSING_ASSISTANT"
    case other = "OTHER"
}
