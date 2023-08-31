//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Ольга Бойко on 21.08.2023.
//

import Foundation
import UserNotifications
import UIKit

final class LocalNotificationsService {
    
    let center = UNUserNotificationCenter.current()
    
    func registerForLatestUpdatesIfPossible() {
        
        AppDelegate().registerUpdatesCategory()
        
        center.requestAuthorization(options: [.sound, .badge, .alert]) { success, error in
            if success {
                print("Уведомления включены")
                let content = UNMutableNotificationContent()
                content.title = "Посмотрите последние обновления"
                content.sound = .defaultCritical
                content.categoryIdentifier = "updates"
                
                var dateComponents = DateComponents()
                dateComponents.hour = 19

                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                self.center.add(request)
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    func registerUpdatesCategory() {
        
        let center = localNS.center
        let action = UNNotificationAction(identifier: "Показать", title: "Показать", options: [.foreground])
        
        let updatesCategory = UNNotificationCategory(identifier: "updates", actions: [action], intentIdentifiers: [])
        let category : Set<UNNotificationCategory> = [updatesCategory]
        
        center.setNotificationCategories(category)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case "Показать":
            print("Пользователь смотрит последние обновления")
        default:
            print("Была нажата неопределенная кнопка")
        }
        completionHandler()
    }
}









