//
//  ChatDIContainer.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 18/3/26.
//

import Foundation
import UIKit

class ChatDIContainer {
    
    struct Dependencies {
        let apiClient: APIClient
    }
    
    internal let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - Flow coordinator
extension ChatDIContainer {
    func makeChatFlowCoordinator(
        navigationController: UINavigationController,
        appNavigator: AppNavigator
    ) -> ChatFlowCoordinator {
        DefaultChatFlowCoordinator(
            navigationController: navigationController,
            diContainer: self,
            appNavigator: appNavigator
        )
    }
}

// MARK: - Screen factories
extension ChatDIContainer {
    
    // Chat List
    func makeChatListViewModel(actions: ChatListViewModelActions) -> ChatListViewModel {
        DefaultChatListViewModel(actions: actions)
    }
    
    func makeChatListViewController(actions: ChatListViewModelActions) -> ChatListViewController {
        let viewModel = makeChatListViewModel(actions: actions)
        return ChatListViewController(viewModel: viewModel)
    }
    
    // Chat Detail
    func makeChatDetailViewModel(actions: ChatDetailViewModelActions) -> ChatDetailViewModel {
        DefaultChatDetailViewModel(actions: actions)
    }
    func makeChatDetailViewController(conversationId: String, actions: ChatDetailViewModelActions) -> ChatDetailViewController {
        var viewModel = makeChatDetailViewModel(actions: actions)
        viewModel.conversationId = conversationId
        return ChatDetailViewController(viewModel: viewModel)
    }
    
    
}
