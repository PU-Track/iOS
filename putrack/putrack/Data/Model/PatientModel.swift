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
    let nextPositionChangeTime: Date
    let humidity: Float
    let temperature: Float
    let sittingTemperature: Float
}

extension PatientDetail {
    func toEntity() -> Patient {
        return Patient(
            id: patientId,
            name: name,
            gender: gender,
            age: age,
            height: Float(height),
            weight: Float(weight),
            status: status,
            lastPositionChangeTime: Date(),
            nextPositionChangeTime: Date(),
            humidity: 0.0,
            temperature: 0.0,
            sittingTemperature: 0.0
        )
    }
}
