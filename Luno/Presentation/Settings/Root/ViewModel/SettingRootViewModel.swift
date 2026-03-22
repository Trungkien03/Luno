//
//  SettingRootViewModel.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 19/3/26.
//

import Foundation
import UIKit

// MARK: - Models

struct SettingItem {
    let title: String
    let icon: UIImage?
    let action: () -> Void
}

struct SettingSection {
    let title: String?          // Header label (nil = no header)
    let items: [SettingItem]
}

// MARK: - Actions

struct SettingRootViewModelActions {
    let showProfile: () -> Void
    let showTheme: () -> Void
}

// MARK: - Protocols

protocol SettingRootViewModelInputs {
    func getSections() -> [SettingSection]
}

protocol SettingRootViewModelOutputs {}

protocol SettingRootViewModel: SettingRootViewModelInputs,
                               SettingRootViewModelOutputs {}

// MARK: - Default Implementation

class DefaultSettingRootViewModel: SettingRootViewModel {

    var actions: SettingRootViewModelActions

    init(actions: SettingRootViewModelActions) {
        self.actions = actions
    }

    func getSections() -> [SettingSection] {
        return [
            SettingSection(
                title: "Account",
                items: [
                    SettingItem(
                        title: "Profile",
                        icon: UIImage(systemName: "person.circle"),
                        action: { [weak self] in self?.actions.showProfile() }
                    ),
                    SettingItem(
                        title: "Logout",
                        icon: UIImage(systemName: "rectangle.portrait.and.arrow.forward"),
                        action: {
                            print("Logout")
                        }
                    )
                ]
            ),
            SettingSection(
                title: "Appearance",
                items: [
                    SettingItem(
                        title: "Theme",
                        icon: UIImage(systemName: "moon.circle"),
                        action: { [weak self] in self?.actions.showTheme() }
                    )
                ]
            )
            // Future sections:
            // SettingSection(title: "Privacy",   items: [...])
            // SettingSection(title: "Additional", items: [...])
        ]
    }
}
