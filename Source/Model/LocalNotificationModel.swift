//
//  LocalNotificationModel.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/30/20.
//

import Foundation

public struct LocalNotificationModel {
    public let id: String
    public let title: String
    public let subtitle: String?
    public let body: String
    public let repeatableDays: [DaysOfWeek]?
    public let dateTime: TimeFromPicker
    public let isActive: Bool
}

public extension LocalNotificationModel {
    init(title: String, subtitle: String? = nil, body: String, repeatableDays: [DaysOfWeek]? = nil, hour: Int, minute: Int, year: Int? = nil, isActive: Bool = true) {
        let currentYear = Calendar.current.component(.year, from: Date())
        let time = TimeFromPicker(hour: hour, minute: minute, year: year ?? currentYear)

        self.id = getRandomID()
        self.title = title
        self.subtitle = subtitle
        self.body = body
        self.repeatableDays = repeatableDays
        self.dateTime = time
        self.isActive = isActive
    }
}

public struct TimeFromPicker {
    let hour: Int
    let minute: Int
    let year: Int

    public init(hour: Int, minute: Int, year: Int) {
        self.hour = hour
        self.minute = minute
        self.year = year
    }
}

public class RealmLocalNotificationModel {

}
