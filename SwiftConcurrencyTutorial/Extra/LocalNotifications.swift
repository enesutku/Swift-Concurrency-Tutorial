// Created by Enes UTKU

import SwiftUI
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification() {
        
        
        // TIME BASED
        
        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // CALENDAR
        var dateComponents = DateComponents()
        dateComponents.hour = 11
        dateComponents.minute = 57
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // LOCATION
        
        let content = UNMutableNotificationContent()
        content.title = "This is notification!"
        content.subtitle = "This was so easy"
        content.sound = .default
        content.badge = 1
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotifications: View {
    var body: some View {
        VStack(spacing: 40) {
            Button(action: {
                NotificationManager.instance.requestAuthorization()
            }, label: {
                Text("Request Permission")
            })
            
            Button(action: {
                NotificationManager.instance.scheduleNotification()
            }, label: {
                Text("Send Notification")
            })
            
        }
    }
}

#Preview {
    LocalNotifications()
}
