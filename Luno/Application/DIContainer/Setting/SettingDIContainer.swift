//
//  SettingDIContainer.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 18/3/26.
//

import Foundation
import UIKit

class SettingDIContainer {

    struct Dependencies {
        let apiClient: APIClient
    }

    internal let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

}

// MARK: - Flow coordinator
extension SettingDIContainer {
    func makeSettingFlowCoordinator(
        navigationController: UINavigationController,
        appNavigator: AppNavigator
    ) -> SettingFlowCoordinator {
        DefaultSettingFlowCoordinator(
            navigationController: navigationController,
            diContainer: self,
            appNavigator: appNavigator
        )
    }
}

// MARK: - Screen factories
extension SettingDIContainer {

    // Setting Root View
    func makeSettingRootViewModel(actions: SettingRootViewModelActions) -> SettingRootViewModel {
        DefaultSettingRootViewModel(actions: actions)
    }
    func makeSettingRootViewController(actions: SettingRootViewModelActions) -> SettingRootViewController {
        let viewModel = makeSettingRootViewModel(actions: actions)
        return SettingRootViewController(viewModel: viewModel)
    }
    
    // Profile Setting View
    func makeProfileSettingViewModel(actions: ProfileSettingViewModelActions) -> ProfileSettingViewModel {
        DefaultProfileViewModel(actions: actions)
    }
    func makeProfileViewController(actions: ProfileSettingViewModelActions) -> ProfileViewSettingController {
        let viewModel = makeProfileSettingViewModel(actions: actions)
        return ProfileViewSettingController(viewModel: viewModel)
    }

    // Theme Setting View
    func makeThemeSettingVieWModel(actions: ThemeSettingViewModelActions) -> ThemeSettingViewModel {
        DefaultThemeSettingViewModel(actions: actions)
    }
    func makeThemeViewController(actions: ThemeSettingViewModelActions) -> ThemeSettingViewController {
        let viewModel = makeThemeSettingVieWModel(actions: actions)
        return ThemeSettingViewController(viewModel: viewModel)
    }
}
