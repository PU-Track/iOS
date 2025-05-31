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
    let alert: String
}

extension WeeklySummaryResponse {
    func toFullChartDataDict() -> [String: [String: [(String, Double)]]] {
        let mapData: ([WeekDataEntry]) -> [String: [(String, Double)]] = { entries in
            return [
                "Air Temp": entries.map { ($0.dayOfWeek, $0.airTemp) },
                "Humidity": entries.map { ($0.dayOfWeek, $0.airHumid) },
                "Sitting Temp": entries.map { ($0.dayOfWeek, $0.cushionTemp) },
            ]
        }
        
        return [
            "This Week": mapData(thisWeekData),
            "Last Week": mapData(lastWeekData)
        ]
    }
    
    func toAlertData() -> [(String, String)] {
        return thisWeekData.map { entry in
            (entry.dayOfWeek, entry.alert)
        }
    }
}
