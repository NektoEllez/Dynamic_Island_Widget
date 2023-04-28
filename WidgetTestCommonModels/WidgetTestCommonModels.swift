//
//  WidgetTestCommonModels.swift
//  WidgetTestCommonModels
//
//  Created by Anton Vlezko on 28.04.2023.
//

import Foundation
import SwiftUI

// MARK: - WidgetStateModel

public struct WidgetStateModel {
    public let state: WidgetState
    public let message: String
    public let hex: String
    public let time: Int?

    public init(
        state: WidgetState,
        message: String,
        hex: String,
        time: Int? = nil
    ) {
        self.state = state
        self.message = message
        self.hex = hex
        self.time = time
    }
}

// MARK: - WidgetState

public enum WidgetState: String {
    case ok
    case warning
    case error
    case waitForResponse
}
