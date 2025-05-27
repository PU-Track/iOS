//
//  FCMTokenRequest.swift
//  putrack
//
//  Created by 신지원 on 5/26/25.
//

import Foundation

struct FCMTokenRequest: Codable {
    let pushToken: String
    
    enum CodingKeys: String, CodingKey {
        case pushToken = "pushToken"
    }
}
