//
//  AppFlowCoordinator.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 18/3/26.
//

import UIKit


protocol NavigationTarget { }

enum ChatNavigationTarget: NavigationTarget {
    case chatList
    case chatDetail(conversationId: String)
}

enum SettingNavigationTarget: NavigationTarget {
    case profile
    case theme
}

protocol AppNavigator: AnyObject {
    func navigate(to target: NavigationTarget, navigationController: UINavigationController?)
}

enum AppTabBarSource: Int, CaseIterable {
//    case chat = 0
    case scripture = 0
    case settings = 1
    
    var tabName: String {
        switch self {
//        case .chat: return "Chat"
        case .scripture: return "Scripture"
        case .settings: return "Settings"
        }
    }
    
    var iconName: UIImage {
        switch self {
//        case .chat: return UIImage(systemName: "message") ?? UIImage()
        case .scripture: return UIImage(systemName: "book") ?? UIImage()
        case .settings: return UIImage(systemName: "gearshape") ?? UIImage()
        }
    }
    
    var selectedIconName: UIImage {
        switch self {
//        case .chat: return UIImage(systemName: "message.fill") ?? UIImage()
        case .scripture: return UIImage(systemName: "book.fill") ?? UIImage()
        case .settings: return UIImage(systemName: "gearshape.fill") ?? UIImage()
        }
    }
    
    var tabBarItem: UITabBarItem {
        UITabBarItem(title: tabName, image: iconName, selectedImage: selectedIconName)
    }
}

protocol AppFlowCoordinator: AnyObject {
    func start()
    func handlePushNotification(payload: [String: Any])
    func logout()
}

// MARK: - 5. THỰC THI (IMPLEMENTATION)
class DefaultAppFlowCoordinator: NSObject, AppFlowCoordinator {
    
    private let appDIContainer: AppDIContainer
    private var navigationController: UINavigationController
    
    // Lưu trữ các coordinator con để tránh bị deallocate (giải phóng bộ nhớ)
    private var childCoordinators: [AnyObject] = []
    
    var appWindow: UIWindow? {
        return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
    }
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        showMainTabBar()
    }
    
    func handlePushNotification(payload: [String : Any]) {
        // Tương lai: Parse Payload để nhày thẳng vào ChatDetail hoặc Setting.
    }
    
    func logout() {
        // Xoá AuthToken -> Chạy lại Window vể màn Login
    }
    
    private func showMainTabBar() {
        let tabBarController = UITabBarController()
        
        let viewControllers = [makeScriptureFlow(), makeSettingFlow()]
        
        tabBarController.viewControllers = viewControllers
        tabBarController.tabBar.tintColor = .systemBlue
        
        // Cấu hình TabBar trong suốt hoàn toàn (Không có background màu trắng)
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        
        // Nếu bạn chỉ muốn xoá cục màu trắng mà vẫn giữ lại hiệu ứng mờ nhám (blur) của iOS
        // thì hãy đổi dòng trên thành: appearance.configureWithDefaultBackground()
        
        tabBarController.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBarController.tabBar.scrollEdgeAppearance = appearance
        }
        
        navigationController.setViewControllers([tabBarController], animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - 6. CHẾ TẠO CÁC NHÁNH MODULE (MODULE FACTORY)
extension DefaultAppFlowCoordinator {
    
//    private func makeChatFlow() -> UINavigationController {
//        let navVC = UINavigationController()
//        navVC.tabBarItem = AppTabBarSource.chat.tabBarItem
//        
//        let chatDI = appDIContainer.makeChatDIContainer()
//        // Nhồi chính bản thân (self as AppNavigator) vào Coordinator con để nó có thể réo tên lúc cần
//        let flow = chatDI.makeChatFlowCoordinator(navigationController: navVC, appNavigator: self)
//        childCoordinators.append(flow)
//        flow.start()
//        
//        return navVC
//    }
    
    private func makeScriptureFlow() -> UINavigationController {
        let navVC = UINavigationController()
        navVC.tabBarItem = AppTabBarSource.scripture.tabBarItem
        
        let scriptureDI = appDIContainer.makeScriptureDIContainer()
        // Nhồi chính bản thân (self as AppNavigator) vào Coordinator con để nó có thể réo tên lúc cần
        let flow = scriptureDI.makeScriptureFlowCoordinator(navigationController: navVC, appNavigator: self)
        childCoordinators.append(flow)
        flow.start()
        
        return navVC
    }
    
    private func makeSettingFlow() -> UINavigationController {
        let navVC = UINavigationController()
        navVC.tabBarItem = AppTabBarSource.settings.tabBarItem
        
        let settingDI = appDIContainer.makeSettingDIContainer()
        let flow = settingDI.makeSettingFlowCoordinator(navigationController: navVC, appNavigator: self)
        childCoordinators.append(flow)
        flow.start()
        
        return navVC
    }
}

// MARK: - 7. XỬ LÝ ĐIỀU HƯỚNG CHÉO (CROSS-MODULE ROUTING)
extension DefaultAppFlowCoordinator: AppNavigator {
    
    func navigate(to target: NavigationTarget, navigationController: UINavigationController?) {
        let activeNav = navigationController ?? self.navigationController
        
        switch target {
        case let chatTarget as ChatNavigationTarget:
            handleChatNavigation(chatTarget, navigationController: activeNav)
            
        case let settingTarget as SettingNavigationTarget:
            handleSettingNavigation(settingTarget, navigationController: activeNav)
            
        // Các Module mở rộng sau này quăng vào đây
        // case let profileTarget as ProfileNavigationTarget: ...
            
        default:
            break
        }
    }
    
    private func handleChatNavigation(_ target: ChatNavigationTarget, navigationController: UINavigationController) {
        let diContainer = appDIContainer.makeChatDIContainer()
        let flowCoordinator = diContainer.makeChatFlowCoordinator(navigationController: navigationController, appNavigator: self)
        flowCoordinator.navigate(to: target)
    }
    
    private func handleSettingNavigation(_ target: SettingNavigationTarget, navigationController: UINavigationController) {
        let diContainer = appDIContainer.makeSettingDIContainer()
        let flowCoordinator = diContainer.makeSettingFlowCoordinator(navigationController: navigationController, appNavigator: self)
        flowCoordinator.navigate(to: target)
    }
}

