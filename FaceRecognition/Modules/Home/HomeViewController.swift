//
//  HomeViewController.swift
//  FaceRecognition
//
//  Created by Su Van Ho on 21/8/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayouts()
        setUpViews()
    }
}

// MARK: - HomeViewInput
extension HomeViewController {
    private func setUpLayouts() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    private func setUpViews() {
        navigationItem.title = "Face Recognition"
        view.backgroundColor = .white
        setUpTableView()
    }

    private func setUpTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Config
extension HomeViewController {
    enum Row: Int, CaseIterable {
        case camera
        case recognize

        var title: String {
            switch self {
            case .camera:
                return "Take pictures for training model"
            case .recognize:
                return "Face Recognition"
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Row.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        let item = Row(rawValue: indexPath.row)
        cell.textLabel?.text = item?.title
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = Row(rawValue: indexPath.row) else { return }
        switch item {
        case .camera:
            navigationController?.pushViewController(TakePicturesViewController(), animated: true)
        case .recognize:
            navigationController?.pushViewController(FaceTrackingController(), animated: true)
        }
    }
}
