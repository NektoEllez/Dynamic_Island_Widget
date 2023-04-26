//
//  MainViewController.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 24.04.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    // MARK: - Properties

    var presenter: MainPresenterInput?

    // MARK: - Private Properties

    private var tableView = MainTableView()

    // MARK: - Inheritance

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter?.viewIsReady()
    }
}

// MARK: - MainViewControllerInput

extension MainViewController: MainViewControllerInput {
    func setView(with viewModel: MainViewModel) {
        navigationItem.title = viewModel.title
        tableView.set(states: viewModel.states)
    }
}

// MARK: - MainTableViewOutput

extension MainViewController: MainTableViewOutput {
    func didSelectItem(indexPath: IndexPath) {
        presenter?.didSelectColor(index: indexPath)
    }
}

// MARK: - Private Methods

extension MainViewController {
    func configure() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.delegate = self
    }
}

