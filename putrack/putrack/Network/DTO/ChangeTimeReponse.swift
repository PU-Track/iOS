//
//  ChangeTimeResponse.swift
//  putrack
//
//  Created by 신지원 on 5/28/25.
//

import Foundation

struct ChangeTimeResponse: Codable {
    let currentDateTime: String
    let predictedDateTime: String
}
