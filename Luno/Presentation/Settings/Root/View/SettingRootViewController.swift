//
//  SettingRootViewController.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 19/3/26.
//

import SnapKit
import UIKit

class SettingRootViewController: UIViewController {

    private var viewModel: SettingRootViewModel!
    private var sections: [SettingSection] = []

    private enum Layout {
        static let rowHeight: CGFloat = 56
        static let cellID = "setting-cell"
    }

    // MARK: - UI Components

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: Layout.cellID)
        tv.rowHeight = Layout.rowHeight
        tv.backgroundColor = .systemGroupedBackground
        tv.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 0)
        return tv
    }()

    // MARK: - Init

    init(viewModel: SettingRootViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    // MARK: - Setup

    func setupUI() {
        title = "Settings"
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func bindViewModel() {
        sections = viewModel.getSections()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension SettingRootViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Layout.cellID, for: indexPath)
        let item = sections[indexPath.section].items[indexPath.row]

        var config = cell.defaultContentConfiguration()
        config.text = item.title
        config.image = item.icon
        config.imageProperties.tintColor = .secondaryLabel
        config.textProperties.font = .systemFont(ofSize: 16, weight: .medium)
        cell.contentConfiguration = config

        cell.accessoryType   = .disclosureIndicator
        cell.tintColor       = .systemBlue
        cell.backgroundColor = .secondarySystemGroupedBackground

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
}

// MARK: - UITableViewDelegate

extension SettingRootViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sections[indexPath.section].items[indexPath.row].action()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Layout.rowHeight
    }
}
