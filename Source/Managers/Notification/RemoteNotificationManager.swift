//
//  RemoteNotificationManager.swift
//  PPT
//
//  Created by Frank Emmanuel on 5/12/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation
import NotificationCenter
import SwiftyJSON

public protocol RemoteNotification: AppConfigure {
    func showRemoteMessage(_ userInfo: [AnyHashable: Any])
    func registerForRemoteNotificationsWithDeviceToken(token: Data)
}

class RemoteNotificationManager: NSObject, RemoteNotification {
    func configure<T>(inType type: T, application: UIApplication) {
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
        App.services.firebaseService.firebasePushNotificationService.registerForRemoteNotificationsWithDeviceToken(token: token)
    }
    
}
