//
//  WidgetService.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 24.04.2023.
//

import Foundation
import WidgetTestCommonModels

// MARK: - WidgetServiceInput

protocol WidgetServiceInput: AnyObject {
    func updateChoosedState(_ model: WidgetStateModel)
    func setIsDynamicIslandEnabled(_ state: Bool)
    func resetActivities()
    func handleDeepLink(_ url: String?)
}

// MARK: - WidgetServiceOutput

protocol WidgetServiceOutput: AnyObject {
    func timerExpired()
}

// MARK: - WidgetService

class WidgetService {

    // MARK: - Properties

    weak var output: WidgetServiceOutput?

    // MARK: - Private Properties
}

// MARK: - WidgetServiceInput

extension WidgetService: WidgetServiceInput {
    func updateChoosedState(_ model: WidgetStateModel) {
        if let time = model.time {
            let timer = Timer.scheduledTimer(
                timeInterval: Double(time),
                target: self,
                selector: #selector(delayedAction),
                userInfo: nil,
                repeats: false
            )
        }

        WidgetServiceStorage.shared.updateChoosedState(model)
    }

    func setIsDynamicIslandEnabled(_ state: Bool) {
        WidgetServiceStorage.shared.setIsDynamicIslandEnabled(state)
    }

    func resetActivities() {
        WidgetServiceStorage.shared.resetActivities()
    }
    
    func handleDeepLink(_ url: String?) {
        if url != nil {
            output?.timerExpired()
        }
    }
}

// MARK: - Private Methods

fileprivate extension WidgetService {

    @objc
    func delayedAction() {
        output?.timerExpired()
    }
}


// MARK: - WidgetServiceStorage

fileprivate class WidgetServiceStorage {

    // MARK: - Properties

    static let shared = WidgetServiceStorage()

    // MARK: - Private Properties

    private let dynamicIslandManager = LiveActivityManager()

    private var choosedState: WidgetStateModel?
    private var dynamicIslandState = false

    // MARK: - Init

    init() {}

    // MARK: - Methods

    func updateChoosedState(_ state: WidgetStateModel) {
        self.choosedState = state
        dynamicIslandManager.updateActivity(state)
    }

    func setIsDynamicIslandEnabled(_ isEnabled: Bool) {
        self.dynamicIslandState = isEnabled

        if isEnabled,
           let choosedState = choosedState {
            dynamicIslandManager.startActivity(choosedState)
        } else {
            dynamicIslandManager.stopActivity()
        }
    }

    func resetActivities() {
        self.dynamicIslandState = false
        dynamicIslandManager.stopActivity()
    }
}
