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
        HStack(alignment: .center, spacing: 30) {
            VStack(alignment: .center, spacing: 8) {
                Image(uiImage: viewModel.patient.gender == .male ? UIImage.patientMan : UIImage.patientWoman)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                
                Text("\(viewModel.patient.name) 환자")
                    .font(.subheadline)
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text("\(viewModel.patient.age)세 \(viewModel.patient.gender)")
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)
                
                Text("현재 상태: \(viewModel.statusText)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("변경 시점: \(viewModel.formattedLastChangeTime)")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom, 4)
                
                Text("유지 시간: \(viewModel.formattedElapsedTime)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("남은 시간: \(viewModel.formattedRemainingTime)")
                    .font(.caption)
                    .foregroundColor(viewModel.remainingTimeColor)
            }
        }
        .padding(.bottom, 4)
    }
}
