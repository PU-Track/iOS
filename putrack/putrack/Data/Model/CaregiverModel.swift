//
//  CaregiverModel.swift
//  putrack
//
//  Created by 신지원 on 5/17/25.
//

struct Caregiver: Identifiable {
    let id: Int
    let name: String
    let gender: Gender
    let role: CaregiverRole
    let age: Int
    let assignedPatients: [Patient]
    let status: CaregiverStatus
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
