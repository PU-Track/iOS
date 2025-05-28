//
//  AlertListResponse.swift
//  putrack
//
//  Created by 신지원 on 5/28/25.
//

import Foundation

struct AlertListResponse: Codable {
    let alertList: [Alert]
}

struct Alert: Codable {
    let content: String
    let timestamp: String
}
