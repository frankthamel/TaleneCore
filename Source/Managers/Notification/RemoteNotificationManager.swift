//
//  RemoteNotificationManager.swift
//  PPT
//
//  Created by Frank Emmanuel on 5/12/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseMessaging
import NotificationCenter
import SwiftyJSON

public protocol RemoteNotification: AppConfigure {
    func showRemoteMessage(_ userInfo: [AnyHashable: Any])
    func registerForRemoteNotificationsWithDeviceToken(token: Data)
}

class RemoteNotificationManager: NSObject, RemoteNotification {
    func configure<T>(inType type: T, application: UIApplication) {

        if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self
          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization( options: authOptions, completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        Messaging.messaging().delegate = self
        application.registerForRemoteNotifications()

    }

    func showRemoteMessage(_ userInfo: [AnyHashable: Any]) {

        let json = JSON(userInfo)
        let title: String = json["aps"]["alert"]["title"].stringValue
        let body: String = json["aps"]["alert"]["body"].stringValue
        let hashTags: String? = json["hashTags"].string
        let openUrl: String? = json["openUrl"].string
        let shareUrl: String? = json["shareUrl"].string
        let imageUrl: String? = json["imageUrl"].string

        let notification: RemoteNotificationModel = RemoteNotificationModel(title: title, body: body, hashTags: hashTags, openUrl: openUrl, shareUrl: shareUrl, imageUrl: imageUrl)

        guard let controller = App.context.activeViewController else {
            return
        }

        let alertModel = CustomAlertModel(type: .custom(AppAlerts.createTCAdsAlert), params: [TCConstants.model: notification.toAdsShareModel()], containerController: controller)
        App.managers.alert.showAlert(model: alertModel)
    }

    func registerForRemoteNotificationsWithDeviceToken(token: Data) {
        Messaging.messaging().apnsToken = token
    }

}

@available(iOS 10, *)
extension RemoteNotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print("UNUserNotificationCenter willPresent", userInfo)
        completionHandler([.alert, .sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("UNUserNotificationCenter didReceive", userInfo)
        completionHandler()
    }

}

extension RemoteNotificationManager: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      print("Firebase registration token: \(fcmToken)")

        let dataDict:[String: String] = ["token": fcmToken]
        App.managers.notification.localNotificationManager.send(notification: "FCMToken", info: dataDict)
    }

    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Message data ", remoteMessage.appData)
    }
}
