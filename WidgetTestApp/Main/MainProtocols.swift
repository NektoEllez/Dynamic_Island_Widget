//
//  MainProtocols.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 24.04.2023.
//

import UIKit

// MARK: - MainPresenterInput

protocol MainPresenterInput: AnyObject {
    init(
        view: MainViewControllerInput,
        widgetService: WidgetServiceProtocol
    )

    func viewIsReady()
    func didSelectColor(index: IndexPath)
}

// MARK: - MainViewControllerOutput

protocol MainViewControllerInput: AnyObject {
    func setView(with viewModel: MainViewModel)
}
