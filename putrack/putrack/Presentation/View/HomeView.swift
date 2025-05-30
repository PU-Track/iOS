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
                HStack(alignment: .center, spacing: 20){
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 120, height: 120)
                        
                        Image(.profileDoctor1)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    }
                    .padding([.top, .trailing], 10)
                    .padding(.leading, 5)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(viewModel.caregiver.name) \(viewModel.roleText)님")
                            .font(.title3).bold()
                            .foregroundColor(.white)
                        
                        Text("상태: \(viewModel.statusText)")
                            .font(.subheadline)
                            .foregroundColor(viewModel.statusColor)
                        
                        Text("담당 환자 수: \(viewModel.caregiver.assignedPatients)명")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(Color.deepBlue)
                
                ZStack(alignment: .center) {
                    BottomRoundedView(radius: 50)
                        .frame(height: 70)
                    
                    //TODO: 로고 넣기
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .bold))
                }
                
                ZStack {
                    Color.white.ignoresSafeArea()
                    
                    List(Array(viewModel.patients.enumerated()), id: \.element.patient.id) { index, viewModel in
                        VStack(spacing: 13) {
                            NavigationLink(destination: PatientView(patientViewModel: viewModel)) {
                                PatientCellView(viewModel: viewModel)
                            }

                            Divider()
                                .frame(height: 0.5)
                                .background(Color.middleBlue)
                        }
                        .listRowBackground(Color.white)
                        .listRowSeparator(.hidden)
                        .padding(.top, index == 0 ? 30 : 0)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                }
                .padding(.horizontal, 5)
            }
        }
        .tint(.gray)
    }
}
