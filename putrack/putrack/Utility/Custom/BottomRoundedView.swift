//
//  BottomRoundView.swift
//  putrack
//
//  Created by 신지원 on 5/30/25.
//

import SwiftUI

struct BottomRoundedView: View {
    var radius: CGFloat

    var body: some View {
        Color.deepBlue
            .clipShape(BottomRoundedCorners(radius: radius))
    }
}

struct BottomRoundedCorners: Shape {
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Start at top-left
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        // Top line
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        // Right line
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
        
        // Bottom-right curve
        path.addQuadCurve(to: CGPoint(x: rect.maxX - radius, y: rect.maxY),
                          control: CGPoint(x: rect.maxX, y: rect.maxY))
        
        // Bottom-left curve
        path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - radius),
                          control: CGPoint(x: rect.minX, y: rect.maxY))
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        return path
    }
}
