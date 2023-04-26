//
//  Clock.swift
//  WidgetTestWidgetExtensionExtension
//
//  Created by Иван Марин on 26.04.2023.
//

import SwiftUI

struct Clock: View {
    var counter: Int
    var countTo: Int
     
    var body: some View {
        VStack {
            Text(counterToMinutes())
                .font(.system(size: 18))
                .fontWeight(.black)
                .scaledToFit()
                .minimumScaleFactor(0.2)
                .lineLimit(1)
        }
    }
     
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
         
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}
