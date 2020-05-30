//
//  LocalPushNotificationManager.swift
//  PPT
//
//  Created by Frank Emmanuel on 5/12/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation
import UserNotifications

public protocol LocalPushNotification: AppConfigure {
    func scheduleTrigger(_ model: LocalNotificationModel)
    func cancelTrigger(ids: [String])
    func updateTrigger(_ model: LocalNotificationModel)
    func listScheduledNotifications(withCompletion completion: @escaping ([LocalNotificationModel]?) -> Void )
    func removeAllPendingNotifications()
}

class LocalPushNotificationManager: NSObject, LocalPushNotification {

    func configure<T>(inType type: T) {
        UNUserNotificationCenter.current().delegate = self
    }

    func scheduleTrigger(_ model: LocalNotificationModel) {
        requestAuthorization(model)
    }

    func cancelTrigger(ids: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
    }

    func updateTrigger(_ model: LocalNotificationModel) {
        cancelTrigger(ids: [model.id])
        scheduleTrigger(model)
    }

    func listScheduledNotifications(withCompletion completion: @escaping ([LocalNotificationModel]?) -> Void ) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in

            let notificationModels: [LocalNotificationModel] = []
            for notification in notifications {
                print(notification.identifier)
                // TODO: get notification from relam db for given identifiers and convert to Alertmodels

            }

            completion(notificationModels)
        }
    }

    private func requestAuthorization(_ model: LocalNotificationModel) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in

            if granted == true && error == nil {
                if let days = model.repeatableDays {
                    days.forEach { (day) in
                        let dateTime = createDate(weekday: day.id, hour: model.dateTime.hour, minute: model.dateTime.minute, year: model.dateTime.year)
                        self.scheduleNotification(for: model, day: day, time: dateTime)
                    }
                } else {
                    let day = Calendar.current.component(.weekday, from: Date())
                    let dateTime = createDate(weekday: day, hour: model.dateTime.hour, minute: model.dateTime.minute, year: model.dateTime.year)
                    self.scheduleNotification(for: model, time: dateTime)
                }
            }
        }
    }

    func scheduleNotification(for model: LocalNotificationModel, day: DaysOfWeek? = nil, time: Date) {

        let triggerWeekly = Calendar.current.dateComponents([.weekday,.hour,.minute,.second,], from: time )

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: day == nil ? false : true)

        let content = UNMutableNotificationContent()
        content.title = model.title

        if let sub = model.subtitle {
            content.subtitle = sub
        }

        content.body = model.body
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "TaleneCoreNotifications"

        let id = "\(model.id)_\(day?.name ?? "")"

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                App.managers.message.showMessage(model: MessageModel(title: TCSay.Notification.notificationCreateErrorTitle, subTitle: TCSay.Notification.notificationCreateErrorSubtitle, type: .error))
                App.managers.logger.error(message: error.localizedDescription)
                App.managers.hapticFeedback.trigger(.error)
            }
        }
    }

    func removeAllPendingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
}


extension LocalPushNotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}


