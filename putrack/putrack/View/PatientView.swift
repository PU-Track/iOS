//
//  PatientView.swift
//  putrack
//
//  Created by 신지원 on 5/17/25.
//

import SwiftUI

struct PatientView: View {
    @ObservedObject var viewModel: PatientViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("🧑‍⚕️ 이름: \(viewModel.patient.name)")
                .font(.title2)
            Text("성별: \(viewModel.genderText)")
            Text("나이: \(viewModel.patient.age)세")
            Text("신장: \(viewModel.patient.height, specifier: "%.1f")cm")
            Text("체중: \(viewModel.patient.weight, specifier: "%.1f")kg")
            Text("상태: \(viewModel.statusText)")
            Text("마지막 체위 변경: \(viewModel.formattedLastChangeTimeWithDetail)")
            Text("현재 앉아있는 시간: \(viewModel.formattedElapsedTimeWithSecond)")
                .foregroundColor(viewModel.remainingTimeColor)
            Text("남은 시간: \(viewModel.formattedRemainingTimeWithSecond)")
                .foregroundColor(viewModel.remainingTimeColor)

            Spacer()
        }
        .padding()
        .navigationTitle("환자 상세 정보")
    }
}
