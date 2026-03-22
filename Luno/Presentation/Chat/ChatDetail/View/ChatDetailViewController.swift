//
//  ChatDetailViewController.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 19/3/26.
//

import UIKit

class ChatDetailViewController: UIViewController {
    
    
    private var viewModel: ChatDetailViewModel!
    
    private enum Layout {
        static let padding: CGFloat = 16
    }

    // MARK: - Initialization
    init(viewModel: ChatDetailViewModel!) {
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
