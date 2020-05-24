//
//  FirebaseAnalyticsService.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/13/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation
import FirebaseAnalytics

public protocol FirebaseAnalyticsService {
    func track(event: AnalyticsEvent)
}

struct FirebaseAnalyticsServiceProvider: FirebaseAnalyticsService {
    func track(event: AnalyticsEvent) {
        Analytics.logEvent(event.name, parameters: event.metadata)
    }
}
