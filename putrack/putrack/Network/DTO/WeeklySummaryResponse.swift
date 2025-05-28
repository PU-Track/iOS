//
//  Untitled.swift
//  putrack
//
//  Created by 신지원 on 5/28/25.
//

import Foundation

struct WeeklySummaryResponse: Codable {
    let lastWeekData: [WeekDataEntry]
    let thisWeekData: [WeekDataEntry]
}

struct WeekDataEntry: Codable {
    let dayOfWeek: String
    let date: String
    let airTemp: Double
    let airHumid: Double
    let cushionTemp: Double
    let changeInterval: Double
}
