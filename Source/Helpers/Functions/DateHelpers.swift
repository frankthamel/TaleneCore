//
//  DateHelpers.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/30/20.
//

import Foundation

public func createDate(weekday: Int, hour: Int, minute: Int, year: Int) -> Date {

    var components = DateComponents()
    components.hour = hour
    components.minute = minute
    components.year = year
    components.weekday = weekday
    components.weekdayOrdinal = 10
    components.timeZone = .current

    let calendar = Calendar(identifier: .iso8601)
    return calendar.date(from: components)!
}
