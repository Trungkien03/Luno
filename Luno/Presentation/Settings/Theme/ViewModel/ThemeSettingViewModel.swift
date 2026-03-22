//
//  ThemeSettingViewModel.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 19/3/26.
//

import UIKit

// MARK: - Actions

struct ThemeSettingViewModelActions {
    var didSelectTheme: ((AppTheme) -> Void)?
}

// MARK: - Protocols

protocol ThemeSettingViewModelInputs {
    func didSelectTheme(at index: Int)
}

protocol ThemeSettingViewModelOutputs {
    var title: String { get }
    var themeOptions: [AppTheme] { get }
    var currentTheme: AppTheme { get }
}

protocol ThemeSettingViewModel: ThemeSettingViewModelInputs,
                                ThemeSettingViewModelOutputs {}

// MARK: - Default Implementation

class DefaultThemeSettingViewModel: ThemeSettingViewModel {

    private let actions: ThemeSettingViewModelActions

    init(actions: ThemeSettingViewModelActions) {
        self.actions = actions
    }

    // MARK: Outputs

    var title: String { "Theme" }
    var themeOptions: [AppTheme] { AppTheme.allCases }
    var currentTheme: AppTheme { ThemeManager.shared.currentTheme.value }

    // MARK: Inputs

    func didSelectTheme(at index: Int) {
        guard let theme = AppTheme(rawValue: index) else { return }
        ThemeManager.shared.setTheme(theme)
        actions.didSelectTheme?(theme)
    }
}
