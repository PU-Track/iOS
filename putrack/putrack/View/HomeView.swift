//
//  HomeView.swift
//  putrack
//
//  Created by 신지원 on 5/15/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("환영합니다, \(viewModel.caregiver.name)님")
                        .font(.title2).bold()
                    
                    Text("역할: \(viewModel.roleText)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("상태: \(viewModel.statusText)")
                        .font(.subheadline)
                        .foregroundColor(viewModel.statusColor)
                    
                    Text("담당 환자 수: \(viewModel.caregiver.assignedPatients.count)명")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
                
                Text("담당 환자 목록")
                    .font(.headline)
                    .padding(.horizontal)
                
                List(viewModel.patients) { patient in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(patient.name)
                                .font(.headline)
                            Spacer()
                            Text("\(patient.age)세")
                                .foregroundColor(.gray)
                        }
                        
                        Text("상태: \(viewModel.statusText(for: patient.status))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text("마지막 체위변경: \(viewModel.formattedDate(patient.lastPositionChangeTime))")
                            .font(.caption)
                        
                        Text("남은 시간: \(viewModel.formattedRemainingTime(patient.remainingTimeToNextChange).0)")
                            .font(.caption)
                            .foregroundColor(viewModel.formattedRemainingTime(patient.remainingTimeToNextChange).1)
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.insetGrouped)
            }
        }
    }
}
