//
//  PatientCellView.swift
//  putrack
//
//  Created by 신지원 on 5/17/25.
//

import SwiftUI

struct PatientCellView: View {
    @ObservedObject var viewModel: PatientViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("\(viewModel.patient.name) (\(viewModel.genderShortText))")
                    .font(.headline)
                Spacer()
                Text("\(viewModel.patient.age)세")
                    .foregroundColor(.gray)
            }

            Text("상태: \(viewModel.statusText)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text("마지막 체위변경: \(viewModel.formattedLastChangeTime)")
                .font(.caption)

            Text("남은 시간: \(viewModel.formattedRemainingTime)")
                .font(.caption)
                .foregroundColor(viewModel.remainingTimeColor)

            Text("현재 앉아있는 시간: \(viewModel.formattedElapsedTime)")
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}
