//
//  AppDIContainer.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 18/3/26.
//

import Foundation

class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    lazy var apiClient: APIClient = {
        // Có thể lấy URL từ AppConfiguration
        let config = DefaultNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!)
        return DefaultAPIClient(config: config)
    }()
    
    // MARK: - Luồng Modules (DIContainers)
    
    func makeChatDIContainer() -> ChatDIContainer {
        // Sinh ra ChatDI và truyền cho nó cái Tầng Mạng để gọi API
        let dependencies = ChatDIContainer.Dependencies(apiClient: apiClient)
        return ChatDIContainer(dependencies: dependencies)
    }
    
    func makeSettingDIContainer() -> SettingDIContainer {
        let dependencies = SettingDIContainer.Dependencies(apiClient: apiClient)
        return SettingDIContainer(dependencies: dependencies)
    }
}
