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
    var status: PostureStatus
    var lastPositionChangeTime: Date
    var nextPositionChangeTime: Date
    var humidity: Float
    var temperature: Float
    var sittingTemperature: Float
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
            humidity: 46.10,
            temperature: 26.70,
            sittingTemperature: 35.7
        )
    }
}
