//
//  Config.swift
//  putrack
//
//  Created by 신지원 on 5/26/25.
//

import Foundation

class Config {
    static var baseURL: String {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            fatalError("BaseURL 없음")
        }
        return url
    }
}
