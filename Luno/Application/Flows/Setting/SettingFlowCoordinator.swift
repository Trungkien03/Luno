//
//  SettingFlowCoordinator.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 19/3/26.
//

import UIKit

protocol SettingFlowCoordinator: AnyObject {
    func start()
    func navigate(to target: SettingNavigationTarget)
}

final class DefaultSettingFlowCoordinator: SettingFlowCoordinator {
    private let navigationController: UINavigationController
    private let diContainer: SettingDIContainer
    private weak var appNavigator: AppNavigator?
    
    init(
        navigationController: UINavigationController,
        diContainer: SettingDIContainer,
        appNavigator: AppNavigator
    ) {
        self.navigationController = navigationController
        self.diContainer = diContainer
        self.appNavigator = appNavigator
    }
    
    func start() {
        showRoot()
    }
    
    func navigate(to target: SettingNavigationTarget) {
        switch target {
        case .profile:
            let actions = ProfileSettingViewModelActions()
            let vc = diContainer.makeProfileViewController(actions: actions)
            navigationController.pushViewController(vc, animated: true)
            
        case .theme:
            let actions = ThemeSettingViewModelActions()
            let vc = diContainer.makeThemeViewController(actions: actions)
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    private func showRoot() {
        let actions = SettingRootViewModelActions(
            showProfile: { [weak self] in self?.navigate(to: .profile) },
            showTheme: { [weak self] in self?.navigate(to: .theme) }
        )
        let vc = diContainer.makeSettingRootViewController(actions: actions)
        navigationController.setViewControllers([vc], animated: false)
    }
}

