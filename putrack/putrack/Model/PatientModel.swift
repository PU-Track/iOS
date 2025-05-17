//
//  Patient.swift
//  putrack
//
//  Created by 신지원 on 5/15/25.
//

import Foundation

struct Patient: Identifiable {
    let id: Int
    let name: String
    let gender: Gender
    let age: Int
    let height: Float
    let weight: Float
    let status: PatientStatus
    let lastPositionChangeTime: Date
    let remainingTimeToNextChange: TimeInterval
}

enum PatientStatus {
    case bedridden
    case sitting
    case sleeping
}
