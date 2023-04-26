//
//  ViZoneIconWidgetView.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 26.04.2023.
//

import SwiftUI

struct IconWidgetView: View {
    
    @State var contextState: WidgetState
    @State var frameWidth: CGFloat
    @State var frameHeight: CGFloat
    
    var body: some View {
        ZStack {
            Image("viZoneIconWidget")
                .resizable()
                .frame(width: frameWidth, height: frameHeight)
                .colorMultiply(contextState.messageColor)
        }
        .padding()
    }
}
