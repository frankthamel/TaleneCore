//
//  Date+TaleneCore.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 7/7/20.
//

import Foundation

public extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }

    func toTimmerText(from date: Date) -> String {
        let s = seconds(from: date)

        let d = s / (60 * 60 * 24)
        let dRemainder = (s % (60 * 60 * 24))

        let h =  dRemainder / (60 * 60)
        let hRemainder = (dRemainder % (60 * 60))
        
        let m = hRemainder / 60
        let rs = Int(hRemainder % 60)

        return "\(d) Days, \(h):\(m):\(rs)"
    }

    func toTimmerValues(from date: Date) -> (days: Int, hours: Int, minutes: Int, seconds: Int) {
        let s = seconds(from: date)

        let d = s / (60 * 60 * 24)
        let dRemainder = (s % (60 * 60 * 24))

        let h =  dRemainder / (60 * 60)
        let hRemainder = (dRemainder % (60 * 60))

        let m = hRemainder / 60
        let rs = Int(hRemainder % 60)

        return (d, h, m, rs)
    }

}
