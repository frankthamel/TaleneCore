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

}
