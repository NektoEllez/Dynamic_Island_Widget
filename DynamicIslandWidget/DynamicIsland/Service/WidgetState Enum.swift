//
//  Enums.swift
//  WidgetTestWidgetExtensionExtension
//
//  Created by Иван Марин on 24.04.2023.
//

import SwiftUI

enum WidgetState: String {
    
    case ok
    case warning
    case error
    case waitForResponse

    var message: String {
        switch self {
        case .ok:
            return "Apload Completed"
        case .warning:
            return "Warning smth wrong"
        case .error:
            return "Error pls reload app"
        case .waitForResponse:
            return "Wait for response"
        }
    }

    var messageColor: Color {
        switch self {
        case .ok: return .green // timer ? .green : .white
        case .warning: return .yellow // timer ? .yellow : .white
        case .error: return .red // timer ? .red : .white
        case .waitForResponse: return .white
        }
    }
}

//func createStateFrom(_ state: WidgetState, message: String, time: Int?) -> WidgetConfiguration {
//    let color: Color
//    switch state {
//    case .ok:
//        color = .green
//    case .warning:
//        color = .yellow
//    case .error:
//        color = .red
//    case .waitForResponse:
//        color = .white
//    }
//    
//    return WidgetConfiguration(message: message, color: color, time: time)
//}

//struct WidgetConfiguration {
//    let message: String
//    let color: Color
//    var time: Int?
//
//    init(
//        message: String,
//        color: Color,
//        time: Int? = nil
//    ) {
//        self.message = message
//        self.color = color
//        self.time = time
//    }
//}
