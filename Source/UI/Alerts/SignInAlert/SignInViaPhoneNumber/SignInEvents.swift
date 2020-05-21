//
//  SignInEvents.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/13/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

struct SignInEvent: AnalyticsEvent {

    var name: String

    var metadata: [String : String]?

    enum Events: String {
        case screenSetup = "SignIn_Alert_Loaded"
    }
}

extension SignInEvent {
    init(_ event: SignInEvent.Events) {
        self.name = event.rawValue
    }

    init(_ event: SignInEvent.Events, metadata: [String : String]) {
        self.name = event.rawValue
        self.metadata = metadata
    }
}
