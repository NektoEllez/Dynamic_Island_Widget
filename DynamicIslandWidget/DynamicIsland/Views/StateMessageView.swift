//
//  StateMessageView.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 26.04.2023.
//

import SwiftUI

struct StateMessageView: View {
    @State var contextState: WidgetState
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Text(contextState.message)
                .font(.system(size: 14)).bold()
                .scaledToFill()
                .minimumScaleFactor(0.2)
                .lineLimit(1)
            
            Text("Update \(Text(Date(), style: .time))")
                .font(.system(size: 10).monospaced())
                .scaledToFill()
                .minimumScaleFactor(0.2)
                .lineLimit(1)
            
            Spacer()
        }
        .padding(10)
    }
}

