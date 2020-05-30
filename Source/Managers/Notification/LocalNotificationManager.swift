//
//  LocalNotificationManager.swift
//  PPT
//
//  Created by Frank Emmanuel on 5/12/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

public protocol LocalNotification: AppConfigure {
    func send(notification: String, info: [String: Any]?)
    func addObserver<T>(forNotification notification: String, inClass type: T, withTarget target: Selector)
    func removeObserver<T>(inClass type: T)
}

struct LocalNotificationManager: LocalNotification {
    func configure<T>(inType type: T) {}

    func send(notification: String, info: [String : Any]?) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification), object: nil, userInfo: info)
    }

    func addObserver<T>(forNotification notification: String, inClass type: T, withTarget target: Selector ) {
        NotificationCenter.default.addObserver(type, selector: target, name: NSNotification.Name(rawValue: notification), object: nil)
    }

    func removeObserver<T>(inClass type: T) {
        NotificationCenter.default.removeObserver(type)
        App.managers.logger.verbose(message: "Notification observers for \(T.self) removed.")
    }

}
