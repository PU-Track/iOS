//
//  PatientListResponse.swift
//  putrack
//
//  Created by 신지원 on 5/28/25.
//

import Foundation

struct PatientListResponse: Codable {
    let patientList: [PatientDetail]
}

struct PatientDetail: Codable {
    let patientId: Int
    let name: String
    let age: Int
    let weight: Double
    let height: Double
    let gender: Gender
    let status: PatientStatus
}

enum PatientStatus: String, Codable {
    case lying = "LYING"
    case sitting = "SITTING"
    case sleeping = "SLEEPING"
}
