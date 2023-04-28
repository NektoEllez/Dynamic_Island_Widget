//
//  StatusCodeView.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 26.04.2023.
//

import SwiftUI
import WidgetTestCommonModels

struct StatusCodeView: View {
    @State var contextState: WidgetStateModel

    var body: some View {
        ZStack {
            // placeholder
            Circle()
            
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 2,
                        dash: [2]
                    )
                )
                .colorMultiply(Color(hex: contextState.hex))
                .frame(width: 80, height: 80)
                .overlay(
                    IconWidgetView(contextState: contextState, frameWidth: 50, frameHeight: 50)
                )
        }
        .frame(width: 72, height: 72)
        .padding(10)
    }
}

