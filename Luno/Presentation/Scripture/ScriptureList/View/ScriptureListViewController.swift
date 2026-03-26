//
//  ScriptureListViewController.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 26/3/26.
//

import UIKit
import SnapKit

class ScriptureListViewController: UIViewController {

    private var viewModel: ScriptureListViewModel!

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()

    private enum Layout {
        static let padding: CGFloat = 16
    }

    // MARK: - Initialization
    init(viewModel: ScriptureListViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // Configuration
    private func setupUI() {
        self.title = "Scriptures"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
