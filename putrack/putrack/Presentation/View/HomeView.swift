//
//  HomeView.swift
//  putrack
//
//  Created by 신지원 on 5/15/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct HomeView: View {
    let userCode: String
    @StateObject private var viewModel: HomeViewModel
    
    init(userCode: String) {
        self.userCode = userCode
        _viewModel = StateObject(wrappedValue: HomeViewModel(userCode: userCode))
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
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
                    .padding([.top, .leading, .trailing])
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.deepBlue)
                    .padding(.bottom, 0)
                    
                    BottomRoundedView(radius: 30)
                        .frame(height: 30)
                }
                
                ZStack {
                    Color.white.ignoresSafeArea()

                    List(viewModel.patients, id: \.patient.id) { viewModel in
                        NavigationLink(destination: PatientView(patientViewModel: viewModel)) {
                            PatientCellView(viewModel: viewModel)
                        }
                        .listRowBackground(Color.white)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
        }
    }
}
