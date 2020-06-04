//
//  FirebasePushNotificationService.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/2/20.
//

import Foundation
import FirebaseCore
import FirebaseMessaging

public protocol FirebasePushNotificationService: AppConfigure {
    func registerForRemoteNotificationsWithDeviceToken(token: Data)
}

class FirebasePushNotificationServiceProvider: NSObject, FirebasePushNotificationService {
    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization( options: authOptions, completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }

        Messaging.messaging().delegate = self
        UIApplication.shared.registerForRemoteNotifications()
    }

    func registerForRemoteNotificationsWithDeviceToken(token: Data) {
        Messaging.messaging().apnsToken = token
    }

}

extension FirebasePushNotificationServiceProvider: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        App.managers.notification.remoteNotificationManager.showRemoteMessage(userInfo)
        completionHandler()
    }
}

extension FirebasePushNotificationServiceProvider: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        let dataDict:[String: String] = ["token": fcmToken]
        App.managers.notification.localNotificationManager.send(notification: "FCMToken", info: dataDict)
    }

    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
    }
}
