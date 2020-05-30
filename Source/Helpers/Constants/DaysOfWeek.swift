//
//  DaysOfWeek.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/30/20.
//

import Foundation

public enum DaysOfWeek: Int {
    case all = 1
    case sunday = 2
    case monday = 3
    case tuesday = 4
    case wednesday = 5
    case thursday = 6
    case friday = 7
    case saturday = 8

    public var all: [String] {
        return  [TCSay.Days.all, TCSay.Days.sunday, TCSay.Days.monday, TCSay.Days.tuesday, TCSay.Days.wednesday, TCSay.Days.thursday, TCSay.Days.friday, TCSay.Days.saturday]
    }

    public var name: String {
        let names: [String] = [TCSay.Days.all, TCSay.Days.sunday, TCSay.Days.monday, TCSay.Days.tuesday, TCSay.Days.wednesday, TCSay.Days.thursday, TCSay.Days.friday, TCSay.Days.saturday]
        return names[self.rawValue - 1]
    }

    public var id: Int {
        return self.rawValue - 1
    }

}
