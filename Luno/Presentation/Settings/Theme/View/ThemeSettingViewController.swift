//
//  ThemeSettingViewController.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 19/3/26.
//

import UIKit
import SnapKit

class ThemeSettingViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: ThemeSettingViewModel!

    private enum Layout {
        static let rowHeight: CGFloat = 56
        static let cellID = "ThemeOptionCell"
    }

    // MARK: - UI Components

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: Layout.cellID)
        tv.rowHeight = Layout.rowHeight
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .systemGroupedBackground
        tv.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 0)
        return tv
    }()

    // MARK: - Initialization

    init(viewModel: ThemeSettingViewModel) {
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
        observeThemeChanges()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    /// Observe ThemeManager so the table reloads when theme changes externally.
    private func observeThemeChanges() {
        ThemeManager.shared.currentTheme.observe { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension ThemeSettingViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.themeOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Layout.cellID, for: indexPath)
        let option  = viewModel.themeOptions[indexPath.row]
        let isSelected = option == viewModel.currentTheme

        var config = cell.defaultContentConfiguration()
        config.text = option.displayName
        config.image = option.icon
        config.imageProperties.tintColor = isSelected ? .systemBlue : .secondaryLabel
        config.textProperties.font = .systemFont(ofSize: 16, weight: .medium)
        cell.contentConfiguration = config

        cell.accessoryType       = isSelected ? .checkmark : .none
        cell.tintColor           = .systemBlue
        cell.backgroundColor     = .secondarySystemGroupedBackground

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Appearance"
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        "Choose your preferred appearance. This setting applies only within the app."
    }
}

// MARK: - UITableViewDelegate
extension ThemeSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectTheme(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Layout.rowHeight
    }
}
