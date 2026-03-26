//
//  ScriptureFlowCoordinator.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 26/3/26.
//


import UIKit

enum ScriptureNavigationTarget: NavigationTarget {
    case scriptureList
    case scriptureDetail(id: String)
}

protocol ScriptureFlowCoordinator: AnyObject {
    func start()
    func navigate(to target: ScriptureNavigationTarget)
}

final class DefaultScriptureFlowCoordinator: ScriptureFlowCoordinator {
    private let navigationController: UINavigationController
    private let diContainer: ScriptureDIContainer
    private weak var appNavigator: AppNavigator?
    
    init(
        navigationController: UINavigationController,
        diContainer: ScriptureDIContainer,
        appNavigator: AppNavigator
    ) {
        self.navigationController = navigationController
        self.diContainer = diContainer
        self.appNavigator = appNavigator
    }
    
    func start() {
        navigate(to: .scriptureList)
    }
    
    func navigate(to target: ScriptureNavigationTarget) {
        switch target {
        case .scriptureList:
            let vc = diContainer.makeScriptureListViewController(actions: ScriptureListViewModelActions())
            navigationController.setViewControllers([vc], animated: false)
            
        case let .scriptureDetail(id):
            let vc = diContainer.makeScriptureDetailViewController(scriptureId: id, actions: ScriptureDetailViewModelActions())
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
