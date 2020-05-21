//
//  AnalyticsManager.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/13/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

struct AnalyticsManager: AnalyticsEngine {

    let firebaseAnalyticsManager: AnalyticsEngine = FirebaseAnalyticsManager()

    func track(event: AnalyticsEvent) {
        firebaseAnalyticsManager.track(event: event)
    }
}
