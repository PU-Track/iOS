//
//  CaregiverResponse.swift
//  putrack
//
//  Created by 신지원 on 5/28/25.
//

import Foundation

struct CaregiverResponse: Codable {
    let name: String
    let age: Int
    let gender: Gender
    let role: CaregiverRole
}
