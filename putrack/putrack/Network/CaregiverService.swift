//
//  CaregiverService.swift
//  putrack
//
//  Created by 신지원 on 5/27/25.
//

import Foundation

final class CaregiverService {
    
    private let baseURL = Config.baseURL
    
    func postRegisterDeviceToken(code: String, deviceData: FCMTokenRequest) async throws {
        var components = URLComponents(string: baseURL + EndPoint.userCaregiverRegisterToken)
        components?.queryItems = [
            URLQueryItem(name: "code", value: code)
        ]
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try JSONEncoder().encode(deviceData)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw NSError(domain: "CaregiverService",
                          code: httpResponse.statusCode,
                          userInfo: [NSLocalizedDescriptionKey: errorMessage])
        }
        
        print("토큰전송완료\n")
    }
}
