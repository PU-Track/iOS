//
//  EndPoint.swift
//  putrack
//
//  Created by 신지원 on 5/26/25.
//

import Foundation

enum EndPoint {
    static let userCaregiverRegisterToken = "user/caregiver/register/token"
    static let userCaregiver = "user/caregiver"
    
    static func patientChangeTime(id: Int) -> String {
        return "patient/\(id)/changeTime"
    }
    
    static func patientAverageData(id: Int) -> String {
        return "patient/\(id)/averageData"
    }
    
    static func patientAlertList(id: Int) -> String {
        return "patient/\(id)/alert"
    }
    
    static func userPatientsList(code: String) -> String {
        return "user/caregiver/\(code)/patients"
    }
}
