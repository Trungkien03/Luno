//
//  ChatFlowCoordinator.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 19/3/26.
//

import UIKit

protocol ChatFlowCoordinator: AnyObject {
    func start()
    func navigate(to target: ChatNavigationTarget)
}

final class DefaultChatFlowCoordinator: ChatFlowCoordinator {
    private let navigationController: UINavigationController
    private let diContainer: ChatDIContainer
    private weak var appNavigator: AppNavigator?
    
    init(
        navigationController: UINavigationController,
        diContainer: ChatDIContainer,
        appNavigator: AppNavigator
    ) {
        self.navigationController = navigationController
        self.diContainer = diContainer
        self.appNavigator = appNavigator
    }
    
    func start() {
        navigate(to: .chatList)
    }
    
    func navigate(to target: ChatNavigationTarget) {
        switch target {
        case .chatList:
            let vc = diContainer.makeChatListViewController(actions: ChatListViewModelActions())
            navigationController.setViewControllers([vc], animated: false)
            
        case let .chatDetail(conversationId):
            let vc = diContainer.makeChatDetailViewController(
                conversationId: conversationId,
                actions: ChatDetailViewModelActions()
            )
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
