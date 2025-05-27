//
//  PatientView.swift
//  putrack
//
//  Created by 신지원 on 5/17/25.
//

import SwiftUI

struct PatientView: View {
    @ObservedObject var patientViewModel: PatientViewModel
    @StateObject private var nfcViewModel = NFCViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("🧑‍⚕️ 이름: \(patientViewModel.patient.name)")
                .font(.title2)
            Text("성별: \(patientViewModel.genderText)")
            Text("나이: \(patientViewModel.patient.age)세")
            Text("신장: \(patientViewModel.patient.height, specifier: "%.1f")cm")
            Text("체중: \(patientViewModel.patient.weight, specifier: "%.1f")kg")
            Text("상태: \(patientViewModel.statusText)")
            Text("마지막 체위 변경: \(patientViewModel.formattedLastChangeTimeWithDetail)")
            Text("현재 앉아있는 시간: \(patientViewModel.formattedElapsedTimeWithSecond)")
                .foregroundColor(patientViewModel.remainingTimeColor)
            Text("남은 시간: \(patientViewModel.formattedRemainingTimeWithSecond)")
                .foregroundColor(patientViewModel.remainingTimeColor)
            
            Spacer()
            
            Button("자세 변경하기") {
                nfcViewModel.startScanning()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .navigationTitle("환자 상세 정보")
    }
}
