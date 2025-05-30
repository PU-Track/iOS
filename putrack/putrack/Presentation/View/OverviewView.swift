//
//  OverviewView.swift
//  putrack
//
//  Created by 신지원 on 5/31/25.
//

import SwiftUI

struct OverviewView: View {
    @StateObject private var viewModel = OverviewViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
            // 타이틀
            Text("OVERVIEW")
                .font(.largeTitle.bold())
            
            // 구분선
            Divider()
                .frame(height: 2)
                .background(Color.gray.opacity(0.3))
                .padding(.horizontal)
                .padding(.bottom, 30)
            
            // 배경 + 버튼 + 차트
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.orange.opacity(0.1))
                    .frame(height: 280)
            
                VStack(alignment: .center, spacing: 0) {
                    metricButtons
                        .padding(.bottom, 30)
                    chartView
                }
                .offset(y: -15)
            }
            .padding(.horizontal, 45)
            .padding(.bottom, 15)
            
            // 요약 정보
            summaryBox
            
            Spacer()
        }
    }
}

extension OverviewView {
    private var metricButtons: some View {
        HStack(spacing: 3) {
            ForEach(viewModel.metrics, id: \.self) { metric in
                Button(action: {
                    viewModel.selectedMetric = metric
                    viewModel.selectedDay = nil
                }) {
                    Text(metric)
                        .font(.caption.bold())
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(viewModel.selectedMetric == metric ? Color.blue : Color.gray.opacity(0.3))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .shadow(radius: 2)
                }
            }
        }
    }
    
    private var chartView: some View {
        VStack {
            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                let barWidth = width / CGFloat(viewModel.currentData.count) * 0.5
                let availableHeight = height - 20
                let range = viewModel.currentRange
                let minHeightRatio: CGFloat = 0.2
                
                HStack(alignment: .bottom, spacing: 10) {
                    Spacer()
                    ForEach(viewModel.currentData, id: \.0) { day, value in
                        let clamped = max(min(value, range.max), range.min)
                        let rawRatio = (clamped - range.min) / (range.max - range.min)
                        let ratio = minHeightRatio + (1 - minHeightRatio) * rawRatio
                        let barHeight = CGFloat(ratio) * availableHeight
                        
                        VStack(spacing: 4) {
                            Text(String(format: "%.1f", value))
                                .font(.caption2)
                                .foregroundColor(.gray)
                            
                            Rectangle()
                                .fill(day == viewModel.selectedDay ? Color.orange : Color.red)
                                .frame(width: barWidth, height: barHeight)
                                .cornerRadius(4)
                                .onTapGesture {
                                    viewModel.selectedDay = day
                                }
                            
                            Text(day)
                                .font(.caption)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
            .frame(height: 200)
        }
    }
    
    private var summaryBox: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("PU-Track Summary")
                .font(.title)
                .bold()
            
            Text(viewModel.summaryText(for: viewModel.selectedDay))
                .font(.body)
                .foregroundColor(.black.opacity(0.8))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.1))
        )
        .padding(.horizontal, 15)
    }
}
