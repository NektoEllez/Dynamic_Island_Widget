//
//  CustomProgressView.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 26.04.2023.
//

import SwiftUI

struct CustomProgressView: View {
    @Binding var progress: CGFloat
    var body: some View {
        ZStack {
            // placeholder
            Circle()
                .stroke(lineWidth: 12)
                .foregroundColor(.gray)
                .opacity(0.2)
            
            // progress circle
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(AngularGradient(colors: [.yellow, .orange, .pink, .red], center: .center), style: StrokeStyle(lineWidth: 12, lineCap: .butt, lineJoin: .miter))
                .rotationEffect(.degrees(-90))
                .shadow(radius: 2)
            
            VStack {
                Text("\(String(format: "%0.0f", progress * 100))%")
                    .font(.system(size: 18).bold())
                    .minimumScaleFactor(0.2)
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
                
                Text("of 100")
                    .font(.system(size: 8).monospacedDigit())
                    .minimumScaleFactor(0.2)
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 72, height: 72)
        .padding(10)
        .animation(.easeInOut, value: progress)
    }
}

