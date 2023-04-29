//
//  CompactLeadingView.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 26.04.2023.
//

import SwiftUI
import WidgetTestCommonModels

struct CompactLeadingView: View {
    @State var contextState: WidgetStateModel

    var body: some View {
        ZStack {
            HStack(alignment: .center) {
                Image("viZoneIconWidget")
                    .resizable()
                    .scaledToFit()
                    .colorMultiply(Color(hex: contextState.hex))

                Text(
                    Date().addingTimeInterval(0),
                    style: .relative
                )
                .font(.system(size: 10).bold())
                .minimumScaleFactor(0.2)
                .lineLimit(1)
                .multilineTextAlignment(.center)
            }
        }
        .padding(1.5)
    }
}
