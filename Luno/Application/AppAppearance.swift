//
//  AppAppearance.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 18/3/26.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
import IQKeyboardToolbarManager

final class AppAppearance {
    func handleIQKeyboardManager() {
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.keyboardDistance = 20.0
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardConfiguration.appearance = .default
    }
    
    func handleIQKeyboardToolbarManager() {
        IQKeyboardToolbarManager.shared.isEnabled = true
    }
}
