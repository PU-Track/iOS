//
//  TestService.swift
//  putrack
//
//  Created by 신지원 on 5/27/25.
//

import Foundation

struct TestRequest: Codable {
    let title: String
    let body: String
}

final class TestService {
    
    private let baseURL = Config.baseURL
    
    func postRegisterDeviceToken(code: String, testData: TestRequest) async throws {
        var components = URLComponents(string: baseURL + EndPoint.testFCMSend)
        components?.queryItems = [
            URLQueryItem(name: "code", value: code)
        ]
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try JSONEncoder().encode(testData)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw NSError(domain: "TestService",
                          code: httpResponse.statusCode,
                          userInfo: [NSLocalizedDescriptionKey: errorMessage])
        }
        
        print("테스트완료\n")
    }
}
