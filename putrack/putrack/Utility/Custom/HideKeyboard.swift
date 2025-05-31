//
//  hideKeyboard.swift
//  putrack
//
//  Created by 신지원 on 5/31/25.
//

import UIKit
import SwiftUICore

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
