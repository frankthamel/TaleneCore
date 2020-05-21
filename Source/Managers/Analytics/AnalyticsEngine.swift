//
//  AnalyticsEngine.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/13/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

public protocol AnalyticsEngine {
    func track(event: AnalyticsEvent)
}

public protocol AnalyticsEvent {
    var name: String { get set }
    var metadata: [String:String]? { get set }
}




