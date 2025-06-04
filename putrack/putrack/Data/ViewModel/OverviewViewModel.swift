//
//  OverviewViewModel.swift
//  putrack
//
//  Created by 신지원 on 5/31/25.
//

import SwiftUI

final class OverviewViewModel: ObservableObject {
    
    let patientId: Int
    @Published var selectedMetric: String = "Humidity"
    @Published var selectedDay: String = "MON"
    
    private let patientService = PatientService()
    
    init(patientId: Int) {
        self.patientId = patientId
        Task {
            await fetchPatientAverageData()
        }
    }
    
    let metrics = ["Humidity", "Air Temp", "Sitting Temp"]
    
    var lastWeekData: [String: [(String, Double)]] = [:]
    var thisWeekData: [String: [(String, Double)]] = [:]
    var thisWeekAlertData: [(String, String)] = []
    
    var thisWeekSelectedData: [(String, Double)] {
        let allDays = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
        let raw = thisWeekData[selectedMetric] ?? []
        let dict = Dictionary(uniqueKeysWithValues: raw)
        return allDays.map { ($0, dict[$0] ?? 0.0) }
    }
    
    var lastWeekSelectedData: [(String, Double)] {
        lastWeekData[selectedMetric] ?? []
    }
    
    var currentRange: (min: Double, max: Double) {
        let values = thisWeekSelectedData.map { $0.1 }
        let nonZeroValues = values.filter { $0 != 0.0 }
        let min = nonZeroValues.min() ?? 0.0
        let max = values.max() ?? 1.0
        
        return (min, max)
    }
    
    func summaryText(for day: String?) -> String {
        if let alert = thisWeekAlertData.first(where: { $0.0 == day })?.1 {
            guard let day else { return alert }
            return "\(day) 의 주간 요약 입니다.\n\(alert)"
        } else {
            return "아직 데이터가 없어요 💁🏻‍♀️ \(day ?? "")."
        }
    }
}

// MARK: - API

extension OverviewViewModel {
    private func fetchPatientAverageData() async {
        do {
            let summary = try await patientService.getPatientAverageData(patientId: patientId)
            let chart = summary.toFullChartDataDict()
            let alertMessage = summary.toAlertData()
            await MainActor.run {
                self.lastWeekData = chart["Last Week"] ?? [:]
                self.thisWeekData = chart["This Week"] ?? [:]
                self.thisWeekAlertData = alertMessage
                
                if let first = self.thisWeekSelectedData.first?.0 {
                    self.selectedDay = first
                }
            }
            print(thisWeekData)
        } catch {
            print("❌ patientService.getPatientAverageData error: \(error)")
        }
    }
}
