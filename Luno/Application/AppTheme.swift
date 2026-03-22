//
//  AppTheme.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 22/3/26.
//

import Foundation
import UIKit

// MARK: - AppTheme

enum AppTheme: Int, CaseIterable {
    case light  = 0
    case dark   = 1
    case system = 2

    var uiStyle: UIUserInterfaceStyle {
        switch self {
        case .light:  return .light
        case .dark:   return .dark
        case .system: return .unspecified
        }
    }

    var displayName: String {
        switch self {
        case .light:  return "Light Mode"
        case .dark:   return "Dark Mode"
        case .system: return "System"
        }
    }

    var icon: UIImage? {
        switch self {
        case .light:  return UIImage(systemName: "sun.max.fill")
        case .dark:   return UIImage(systemName: "moon.fill")
        case .system: return UIImage(systemName: "circle.lefthalf.filled")
        }
    }
}

// MARK: - ThemeManager

class ThemeManager {
    static let shared = ThemeManager()

    let currentTheme = Observable<AppTheme>(value: .system)

    private init() {}

    func setTheme(_ theme: AppTheme) {
        currentTheme.value = theme

        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .forEach {
                $0.overrideUserInterfaceStyle = theme.uiStyle
                $0.setNeedsLayout()
                $0.layoutIfNeeded()
            }
    }
}
