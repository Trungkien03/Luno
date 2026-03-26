//
//  ScriptureDIContainer.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 26/3/26.
//

import Foundation
import UIKit

class ScriptureDIContainer {

    struct Dependencies {
        let apiClient: APIClient
    }

    internal let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

}

// MARK: - Flow coordinator
extension ScriptureDIContainer {
    func makeScriptureFlowCoordinator(
        navigationController: UINavigationController,
        appNavigator: AppNavigator
    ) -> ScriptureFlowCoordinator {
        DefaultScriptureFlowCoordinator(
            navigationController: navigationController,
            diContainer: self,
            appNavigator: appNavigator
        )
    }
}

// MARK: - Screen factories
extension ScriptureDIContainer {

    // Scupture List
    private func makeScriptureListViewModel(actions: ScriptureListViewModelActions) -> ScriptureListViewModel {
        DefaultScriptureListViewModel(actions: actions)
    }
    func makeScriptureListViewController(actions: ScriptureListViewModelActions) -> ScriptureListViewController {
        let viewModel = makeScriptureListViewModel(actions: actions)
        return ScriptureListViewController(viewModel: viewModel)
    }
    
    // ScriptureDetail
    private func makeScriptureDetailViewModel(actions: ScriptureDetailViewModelActions) -> ScriptureDetailViewModel {
        DefaultScriptureDetailViewModel(actions: actions)
    }
    func makeScriptureDetailViewController(scriptureId: String, actions: ScriptureDetailViewModelActions) -> ScriptureDetailViewController {
        var viewModel = makeScriptureDetailViewModel(actions: actions)
        viewModel.scriptureId = scriptureId
        return ScriptureDetailViewController(viewModel: viewModel)
    }
}
