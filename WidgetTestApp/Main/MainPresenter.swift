//
//  MainPresenter.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 24.04.2023.
//

import Foundation
import WidgetTestCommonModels

class MainPresenter {

    // MARK: - Private Properties

    private weak var view: MainViewControllerInput?
    private var widgetService: WidgetServiceInput?

    private var viewModel = MainViewModel()

    // MARK: - Init

    required init(
        view: MainViewControllerInput,
        widgetService: WidgetServiceInput
    ) {
        self.view = view
        self.widgetService = widgetService
    }
}

// MARK: - MainPresenterInput

extension MainPresenter: MainPresenterInput {
    func viewIsReady() {
        widgetService?.resetActivities()

        viewModel.title = "Widget Test"
        
        viewModel.states = [
            "ok",
            "warning",
            "error",
            "waiting"
        ]

        view?.setView(with: viewModel)
    }

    func didSelectColor(index: IndexPath) {
        let state = viewModel.states[index.row]
        widgetService?.updateChoosedState(WidgetStateModel(
            state: WidgetState(rawValue: state) ?? .ok,
            message: "Lorem ipsum",
            hex: "#008000"
        ))
    }
}
