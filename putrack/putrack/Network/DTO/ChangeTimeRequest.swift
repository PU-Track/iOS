//
//  ChangeTimeRequest.swift
//  putrack
//
//  Created by 신지원 on 5/28/25.
//

import Foundation

struct ChangeTimeRequest: Codable {
    let status: PostureStatus
    let airTemp: Double
    let airHumid: Double
    let cushionTemp: Double
    let postureStartTime: String
}

enum PostureStatus: String, Codable {
    case lying = "LYING"
    case sitting = "SITTING"
    case sleeping = "SLEEPING"
}
