//
//  NotificationManager.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 26/3/26.
//

import Foundation
import UIKit
import UserNotifications
import StoreKit

/**
 * NotificationManager handles all local and push notification permissions.
 * It ensures the app stays synced with iOS system settings.
 */
final class NotificationManager {
    static let shared = NotificationManager()
    private init() {}
    
    /// Checks the current notification authorization status from the system.
    func checkStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    /// Triggers the system alert to ask the user for notification permissions.
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error { print("DEBUG: Auth error \(error)") }
        }
    }
    
    /// Logic for the UI toggle: If disabled, opens settings. If enabled, clears pending notifications.
    func toggleNotifications() {
        checkStatus { status in
            if status == .denied || status == .notDetermined {
                self.openAppSettings()
            } else {
                let center = UNUserNotificationCenter.current()
                center.removeAllDeliveredNotifications()
                center.removeAllPendingNotificationRequests()
            }
        }
    }
    
    /// Redirects the user directly to the App's specific settings in iOS System Settings.
    private func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

/**
 * Utils contains helper functions for Deep Linking and external App Store redirection.
 */
struct DeepLinkUtils {
    
    enum SocialApp: String, CaseIterable {
        case facebook = "fb://"
        case linkedin = "linkedin://"
        case youtube = "youtube://"
        case whatsapp = "whatsapp://"
        case telegram = "tg://"
        case zoom = "zoomus://"
        case msTeams = "msteams://"
        
        var appStoreID: Int {
            switch self {
            case .facebook: return 284882215
            case .linkedin: return 288429040
            case .youtube:  return 544007664
            case .whatsapp: return 310633997
            case .telegram: return 686449807
            case .zoom:     return 546505307
            case .msTeams:  return 1113153706
            }
        }
    }
    
    /// Opens a specific social app using deep links. If the app is not installed, it opens the App Store.
    /// - Parameters:
    ///   - app: The target SocialApp enum.
    ///   - deepLinkURL: The specific path (e.g., meeting ID or profile link).
    ///   - viewController: The parent VC to present the App Store controller if needed.
    static func openExternalApp(_ app: SocialApp, deepLinkURL: String, from viewController: UIViewController) {
        guard let scheme = URL(string: app.rawValue) else { return }
        
        if UIApplication.shared.canOpenURL(scheme) {
            if let targetURL = URL(string: deepLinkURL) {
                UIApplication.shared.open(targetURL, options: [:])
            }
        } else {
            // App not installed, show App Store inside the app
            let storeVC = SKStoreProductViewController()
            storeVC.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: NSNumber(value: app.appStoreID)])
            viewController.present(storeVC, animated: true)
        }
    }
}
