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
        let currentUser = App.managers.authenticator.getCurrentUser()
        var modifiedEvent = event

        if var metadata = event.metadata, let user = currentUser {
            metadata["uid"] = user.id
            modifiedEvent.metadata = metadata
        } else if let user = currentUser {
            let metadata = ["uid": user.id]
            modifiedEvent.metadata = metadata
        }

        firebaseAnalyticsManager.track(event: modifiedEvent)
    }
}
