//
//  HomeViewModel.swift
//  putrack
//
//  Created by 신지원 on 5/17/25.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var caregiver: Caregiver = Caregiver(name: "", gender: .male, role: .caregiver, age: 0, assignedPatients: 0, status: .working)
    @Published var patients: [PatientViewModel] = []
    var userCode: String
    
    private let caregiverService = CaregiverService()
    private let patientService = PatientService()
    
    init(userCode: String) {
        
        // 초기 데이터 세팅
        self.userCode = userCode
        Task {
            await fetchCaregiverData()
            await fetchPatientListData()
        }
    }
    
    var roleText: String {
        switch caregiver.role {
        case .doctor: return "의사"
        case .nurse: return "간호사"
        case .nursingAssistant: return "간호조무사"
        case .caregiver: return "요양보호사"
        case .other: return "기타"
        }
    }
    
    var statusText: String {
        switch caregiver.status {
        case .working: return "근무 중"
        case .resting: return "휴식 중"
        case .offToday: return "휴무"
        }
    }
    
    var statusColor: Color {
        switch caregiver.status {
        case .working: return .green
        case .resting: return .orange
        case .offToday: return .red
        }
    }
}

// MARK: - API

extension HomeViewModel {
    private func fetchCaregiverData() async {
        do {
            let dto = try await caregiverService.getCaregiverData(code: userCode)
            await MainActor.run {
                self.caregiver = dto.toEntity()
                print(dto)
            }
        } catch {
            print("❌ caregiverService.getCaregiverData error: \(error)")
        }
    }
    
    private func fetchPatientListData() async {
        do {
            let dto = try await patientService.getPatientsList(code: userCode).patientList
            let vms = dto.map { PatientViewModel(patient: $0.toEntity()) }
            await MainActor.run {
                self.patients = vms
                print(vms)
            }
        } catch {
            print("❌ patientService.getPatientsList error: \(error)")
        }
    }
}
