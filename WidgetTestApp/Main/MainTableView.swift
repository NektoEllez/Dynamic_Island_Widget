//
//  MainView.swift
//  WidgetTestApp
//
//  Created by Иван Марин on 24.04.2023.
//

import UIKit
import SnapKit

protocol MainTableViewOutput: AnyObject {
    func didSelectItem(indexPath: IndexPath)
}

class MainTableView: UIView {

    // MARK: - Properties

    weak var delegate: MainTableViewOutput?

    // MARK: - Private Properties

    private var stateValues: [String] = []

    private var tableView = UITableView(frame: .zero, style: .insetGrouped)

    // MARK: - Construction

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func set(states: [String]) {
        self.stateValues = states
        tableView.reloadData()
    }
}

// MARK: - Configure UI

extension MainTableView {
    private func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.layer.masksToBounds = false
        tableView.backgroundColor = .systemGroupedBackground

        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension

        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "States"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stateValues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let model = stateValues[indexPath.row]
        cell.textLabel?.text = model

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
