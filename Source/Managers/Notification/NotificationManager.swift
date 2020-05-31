//
//  NotificationManager.swift
//  PPT
//
//  Created by Frank Emmanuel on 5/12/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

public protocol Notification: AppConfigure {
    var remoteNotificationManager: RemoteNotification { get set }
    var localPushNotificationManager: LocalPushNotification { get set }
    var localNotificationManager: LocalNotification { get set }
}

struct NotificationManager: Notification {
    var remoteNotificationManager: RemoteNotification = RemoteNotificationManager()
    var localPushNotificationManager: LocalPushNotification = LocalPushNotificationManager()
    var localNotificationManager: LocalNotification = LocalNotificationManager()

    func configure<T>(inType type: T, application: UIApplication) {
        remoteNotificationManager.configure(inType: type, application: application)
        localPushNotificationManager.configure(inType: type, application: application)
        localNotificationManager.configure(inType: type, application: application)
    }
}
