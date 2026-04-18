//
//  CustomSlider.swift
//  AppMusica
//
//  Created by Jessica Costa on 18/04/26.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double
    var range: ClosedRange<Double>
    var onEditingChanged: (Bool) -> Void
    
    var trackColor: Color = .white.opacity(0.2)
    var progressColor: Color = .white
    var thumbColor: Color = .white
    var trackHeight: CGFloat = 4
    var thumbSize: CGFloat = 14
    
    @State private var isDragging = false
    
    private var progressAnimation: Animation? {
        isDragging ? nil : .linear(duration: 0.20)
    }
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let safeRange = max(range.upperBound - range.lowerBound, 0.0001)
            let progress = CGFloat((value - range.lowerBound) / safeRange)
            let clampedProgress = min(max(progress, 0), 1)
            let currentThumbSize = isDragging ? thumbSize + 2 : thumbSize
            
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(trackColor)
                    .frame(height: trackHeight)
                
                Capsule()
                    .fill(progressColor)
                    .frame(width: clampedProgress * width, height: trackHeight)
                    .animation(progressAnimation, value: clampedProgress)
                
                Circle()
                    .fill(thumbColor)
                    .frame(width: currentThumbSize, height: currentThumbSize)
                    .shadow(color: .black.opacity(0.15), radius: 3, y: 1)
                    .offset(x: clampedProgress * width - currentThumbSize / 2)
                    .animation(progressAnimation, value: clampedProgress)
            }
            .frame(height: max(trackHeight, thumbSize))
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        if !isDragging {
                            isDragging = true
                            onEditingChanged(true)
                        }
                        
                        let x = min(max(gesture.location.x, 0), width)
                        let percent = x / width
                        let newValue = range.lowerBound + Double(percent) * safeRange
                        value = newValue
                    }
                    .onEnded { gesture in
                        let x = min(max(gesture.location.x, 0), width)
                        let percent = x / width
                        let newValue = range.lowerBound + Double(percent) * safeRange
                        value = newValue
                        
                        isDragging = false
                        onEditingChanged(false)
                    }
            )
            .animation(.easeOut(duration: 0.18), value: isDragging)
        }
        .frame(height: max(trackHeight, thumbSize))
    }
}
