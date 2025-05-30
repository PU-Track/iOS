//
//  OverviewViewModel.swift
//  putrack
//
//  Created by 신지원 on 5/31/25.
//

import SwiftUI

final class OverviewViewModel: ObservableObject {
    @Published var selectedMetric: String = "Air Temp"
    @Published var selectedDay: String? = nil
    
    let metrics = ["Air Temp", "Humidity", "Sitting Temp"]
    
    let dataDict: [String: [(String, Double)]] = [
        "Air Temp": [
            ("Mon", 26.5), ("Tue", 27.1), ("Wed", 26.8),
            ("Thu", 27.4), ("Fri", 26.7), ("Sat", 27.2), ("Sun", 26.9)
        ],
        "Humidity": [
            ("Mon", 45.0), ("Tue", 50.0), ("Wed", 48.0),
            ("Thu", 52.0), ("Fri", 47.0), ("Sat", 49.0), ("Sun", 46.0)
        ],
        "Sitting Temp": [
            ("Mon", 36.5), ("Tue", 37.1), ("Wed", 36.8),
            ("Thu", 37.2), ("Fri", 36.9), ("Sat", 37.0), ("Sun", 36.7)
        ]
    ]
    
    var currentData: [(String, Double)] {
        dataDict[selectedMetric] ?? []
    }
    
    var currentRange: (min: Double, max: Double) {
        let values = currentData.map { $0.1 }
        return (values.min() ?? 0.0, values.max() ?? 1.0)
    }
    
    func summaryText(for day: String?) -> String {
        guard let day = day else {
            return "Tap a bar to view the summary for that day."
        }
        return "\(day)'s \(selectedMetric.lowercased()) reading was selected."
    }
}
