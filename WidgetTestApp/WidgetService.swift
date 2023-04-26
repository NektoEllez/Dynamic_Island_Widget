//
//  WidgetService.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 24.04.2023.
//

import Foundation

// MARK: - WidgetServiceProtocol

protocol WidgetServiceProtocol: AnyObject {
    func updateChoosedState(_ state: String)
    func changeState(_ state: Bool)
    func resetActivities()
    func handleDeepLink(_ url: String)
}

// MARK: - WidgetServiceDelegate

protocol WidgetServiceDelegate: AnyObject {
    func timerExpired()
}

// MARK: - WidgetServiceProtocol

class WidgetService {

    // MARK: - Properties

    static let shared = WidgetService()
    weak var delegate: WidgetServiceDelegate?

    // MARK: - Private Properties

    private let dynamicIslandManager = LiveActivityManager()

    private var choosedState: String
    private var dynamicIslandState = false

    // MARK: - Init

    init() {
        choosedState = "error"
    }
}

// MARK: - WidgetServiceProtocol

extension WidgetService: WidgetServiceProtocol {
    
    func updateChoosedState(_ state: String) {
        // поменять на enum,
        // принимаюшее свойство принимает string
        // updateChoosedState(_state: Enum)
        self.choosedState = state
        dynamicIslandManager.updateActivity(choosedState)
    }

    func changeState(_ state: Bool) {
        self.dynamicIslandState = state

        switch dynamicIslandState {
        case true:
            dynamicIslandManager.startActivity(choosedState)
        case false:
            dynamicIslandManager.stopActivity()
        }
    }

    func resetActivities() {
        self.dynamicIslandState = false
        dynamicIslandManager.stopActivity()
    }
    
    func handleDeepLink(_ url: String) {
        
        if url == "Pidor" {
            delegate?.timerExpired()
        }
    }
}
