//
//  AppConfiguration.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 18/3/26.
//

import Foundation

final class AppConfiguration {

    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
}
