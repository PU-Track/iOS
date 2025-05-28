//
//  PatientService.swift
//  putrack
//
//  Created by 신지원 on 5/28/25.
//

import Foundation

final class PatientService {
    
    private let baseURL = Config.baseURL
    
    //환자 체위변경 정보 API
    func postPatientChangeTime(patientId: Int, patientData: ChangeTimeRequest) async throws -> ChangeTimeResponse {
        let components = URLComponents(string: baseURL + EndPoint.patientChangeTime(id: patientId))
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try JSONEncoder().encode(patientData)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw NSError(domain: "PatientService",
                          code: httpResponse.statusCode,
                          userInfo: [NSLocalizedDescriptionKey: errorMessage])
        }
        
        print("❣️ 환자 체위변경 정보 POST 완료\n")
        
        let decoder = JSONDecoder()
        return try decoder.decode(ChangeTimeResponse.self, from: data)
    }
    
    //환자 주간 정보 API
    func getPatientAverageData(patientId: Int) async throws -> WeeklySummaryResponse {
        let components = URLComponents(string: baseURL + EndPoint.patientAverageData(id: patientId))
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw NSError(domain: "PatientService",
                          code: httpResponse.statusCode,
                          userInfo: [NSLocalizedDescriptionKey: errorMessage])
        }
        print("❣️ 환자 주간 정보 GET 완료\n")
        
        let decoder = JSONDecoder()
        return try decoder.decode(WeeklySummaryResponse.self, from: data)
    }
    
    //간병인에 대한 환자 정보 리스트 API
    func getPatientsList(code: String) async throws -> PatientListResponse {
        let components = URLComponents(string: baseURL + EndPoint.userPatientsList(code: code))

        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw NSError(domain: "PatientService",
                          code: httpResponse.statusCode,
                          userInfo: [NSLocalizedDescriptionKey: errorMessage])
        }
        
        print("❣️ 간병인에 대한 환자 정보 리스트 GET 완료\n")
        
        let decoder = JSONDecoder()
        return try decoder.decode(PatientListResponse.self, from: data)
    }
    
    //알림 정보 리스트 API
    func getAlertList(patientId: Int) async throws -> AlertListResponse {
        let components = URLComponents(string: baseURL + EndPoint.patientAlertList(id: patientId))

        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw NSError(domain: "PatientService",
                          code: httpResponse.statusCode,
                          userInfo: [NSLocalizedDescriptionKey: errorMessage])
        }
        
        print("❣️ 알림 정보 리스트 GET 완료\n")
        
        let decoder = JSONDecoder()
        return try decoder.decode(AlertListResponse.self, from: data)
    }
}
