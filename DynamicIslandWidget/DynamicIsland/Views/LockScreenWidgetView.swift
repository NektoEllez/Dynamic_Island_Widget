//
//  LockScreenWidgetView.swift
//  DynamicIslandWidget
//
//  Created by Иван Марин on 15.05.2023.
//

import SwiftUI
import WidgetTestCommonModels

struct LockScreenWidgetView: View {
    
    @State var contextState: WidgetStateModel
    @State var progressValue: CGFloat
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .center) {
                Spacer(minLength: 20)
                HStack {
                    switch contextState.state {
                    case .error, .warning, .ok:
                        Image("viZoneIconWidget")
                            .colorMultiply(Color(hex: contextState.hex))
                        Text(contextState.message)
                            .font(Font.system(.body, design: .monospaced))
                            .minimumScaleFactor(0.2)
                            .lineLimit(1)
                    case .waitForResponse:
                        CustomProgressView(progress: self.$progressValue, frameWidth: 55, lineWidth: 8)
                            .overlay(
                                Image("viZoneIconWidget")
                                    .colorMultiply(Color(hex: contextState.hex))
                            )
                        Text(contextState.message)
                            .font(Font.system(.body, design: .monospaced))
                            .minimumScaleFactor(0.2)
                            .lineLimit(1)
                    }
                    
                }
                .scaledToFit()
                Spacer(minLength: 20)
            }
        }
    }
}
