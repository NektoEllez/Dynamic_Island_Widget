//
//  ViZoneIconWidgetView.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 26.04.2023.
//

import SwiftUI
import WidgetTestCommonModels

struct IconWidgetView: View {
    
    @State var contextState: WidgetStateModel
    @State var frameWidth: CGFloat
    @State var frameHeight: CGFloat
    
    var body: some View {
        ZStack {
            Image("viZoneIconWidget")
                .resizable()
                .frame(width: frameWidth, height: frameHeight)
                .colorMultiply(Color(hex: contextState.hex))
        }
        .padding()
    }
}
