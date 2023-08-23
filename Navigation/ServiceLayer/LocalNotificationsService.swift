//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Ольга Бойко on 21.08.2023.
//

import Foundation
import UserNotifications

final class LocalNotificationsService {
    
    let center = UNUserNotificationCenter.current()
    
    func registerForLatestUpdatesIfPossible() {
        
        center.requestAuthorization(options: [.sound, .badge, .provisional]) { success, error in
            if success {
                print("Уведомления включены")
                let content = UNMutableNotificationContent()
                content.title = "Посмотрите последние обновления"
                content.sound = .default
                
//                var dateComponents = DateComponents()
//                dateComponents.hour = 19
//                dateComponents.minute = 21
//
//                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
//
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                self.center.add(request)
                
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
