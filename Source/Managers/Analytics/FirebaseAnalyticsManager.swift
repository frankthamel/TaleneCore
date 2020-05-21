//
//  FirebaseAnalyticsManager.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/13/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

struct FirebaseAnalyticsManager: AnalyticsEngine {
    func track(event: AnalyticsEvent) {
        App.managers.logger.info(message: "Firebase Analytics tracked event: \(event.name)")
    }
}
