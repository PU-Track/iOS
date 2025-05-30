//
//  PatientView.swift
//  putrack
//
//  Created by 신지원 on 5/17/25.
//

import SwiftUI

struct PatientView: View {
    @ObservedObject var patientViewModel: PatientViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack(alignment: .center, spacing: 30) {
                Image(uiImage: patientViewModel.patient.gender == .male ? UIImage.patientMan : UIImage.patientWoman)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 130, height: 130)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(patientViewModel.patient.name)")
                        .font(.title3)
                    
                    Text("\(patientViewModel.patient.age)세  \(patientViewModel.genderText)")
                        .font(.title3)
                    
                    Text("\(patientViewModel.patient.height, specifier: "%.1f")cm  \(patientViewModel.patient.weight, specifier: "%.1f")kg")
                        .font(.title3)
                }
            }
            
            Divider()
                .frame(height: 4)
                .background(Color.gray.opacity(0.3))
                .padding([.top, .bottom], 15)
            
            VStack(alignment: .center, spacing: 7) {
                HStack(alignment: .center, spacing: 0) {
                    // 온도 카드
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.middleBlue, Color.gray]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Image(systemName: "thermometer")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white.opacity(0.1))
                            .offset(x: -30, y: -10)
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text(String(format: "%.1f°C", patientViewModel.patient.temperature))
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.white)
                                    .padding(12)
                            }
                        }
                    }
                    .frame(height: 100)
                    .clipped()
                    
                    Spacer()
                    
                    // 습도 카드
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.middleBlue, Color.gray]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Image(systemName: "humidity.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 75, height: 75)
                            .foregroundColor(.white.opacity(0.1))
                            .offset(x: -30, y: -10)
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text(String(format: "%.1f%%", patientViewModel.patient.humidity))
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.white)
                                    .padding(12)
                            }
                        }
                    }
                    .frame(height: 100)
                    .clipped()
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.gray, Color.middleBlue]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("\(patientViewModel.patient.status.rawValue)")
                        .font(.title.bold())
                        .foregroundColor(.white.opacity(0.8))
                        .offset(x: -100, y: -20)
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("\(patientViewModel.formattedLastChangeTimeWithDetail)")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding(12)
                        }
                    }
                }
                .frame(height: 100)
                .clipped()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.gray, Color.middleBlue]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    VStack {
                        // ELAPSED 블럭
                        ZStack {
                            Text("ELAPSED")
                                .font(.title.bold())
                                .foregroundColor(.white.opacity(0.8))
                                .offset(x: -80, y: -10)
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text(patientViewModel.formattedElapsedTimeWithSecond)
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .padding(.trailing, 12)
                                }
                            }
                        }
                        
                        Divider()
                            .frame(height: 1.5)
                            .background(Color.white)
                        
                        // REMAINING 블럭
                        ZStack {
                            Text("REMAINING")
                                .font(.title.bold())
                                .foregroundColor(.white.opacity(0.8))
                                .offset(x: -80, y: -10)
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text(patientViewModel.formattedRemainingTimeWithSecond)
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .padding([.bottom, .trailing] ,12)
                                }
                            }
                        }
                        Spacer()
                    }
                }
                .frame(height: 200)
            }
            .padding([.horizontal], 20)
            
            HStack(alignment: .center, spacing: 20) {
                NavigationLink(destination: ChangeView(status: patientViewModel.statusText)) {
                    Text("POSTURE CHANGE")
                        .padding()
                        .background(Color.deepCoral)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .padding(.top, 20)
                
                NavigationLink(destination: OverviewView()) {
                    Text("OVERVIEW")
                        .padding()
                        .background(Color.deepCoral)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .padding(.top, 20)
            }
            
            Spacer()
        }
    }
}
