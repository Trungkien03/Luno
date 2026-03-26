//
//  ScriptureListViewController.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 26/3/26.
//

import UIKit

class ScriptureListViewController: UIViewController {

    private var viewModel: ScriptureListViewModel!
    
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

        // Do any additional setup after loading the view.
    }


}
