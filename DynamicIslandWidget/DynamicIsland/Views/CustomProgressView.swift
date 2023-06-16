//
//  CustomProgressView.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 26.04.2023.
//

import SwiftUI

struct CustomProgressView: View {
    
    @Binding var progress: CGFloat
    @State var frameWidth: CGFloat = 0.0
    @State var lineWidth: CGFloat = 0.0
    
    var body: some View {
            ZStack {
                // placeholder
                Circle()
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(.gray)
                    .opacity(0.2)
                // progress circle
                Circle()
                    .trim(from: 0.0, to: min(progress, 0.1))
                    .stroke(
                        AngularGradient(colors: [.yellow, .orange, .pink, .red], center: .center),
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .butt, lineJoin: .miter)
                    )
                    .rotationEffect( .degrees( -90 ) )
                    .shadow(radius: 2)
                VStack {
                    if let frame = frameWidth, frame > 70 {
                        Text("\(String(format: "%0.0f", progress * 100))%")
                            .font(.system(size: 18).bold())
                            .minimumScaleFactor(0.2)
                            .lineLimit(1)
                            .multilineTextAlignment(.center)
                    }

            }
            .frame(width: frameWidth, height: frameWidth)
            .animation(.easeInOut, value: progress)
        }
    }
}
