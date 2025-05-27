//
//  AppState.swift
//  putrack
//
//  Created by 신지원 on 5/17/25.
//

import SwiftUI

final class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var userCode: String? = nil
}
