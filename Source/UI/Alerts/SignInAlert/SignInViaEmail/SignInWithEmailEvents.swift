//
//  SignInWithEmailEvents.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/23/20.
//

import Foundation

struct SignInWithEmailEvents: AnalyticsEvent {

    var name: String

    var metadata: [String : String]?

    enum Events: String {
        case screenSetup = "SignInWithEmail_Alert_Loaded"
    }
}

extension SignInWithEmailEvents {
    init(_ event: SignInWithEmailEvents.Events) {
        self.name = event.rawValue
    }

    init(_ event: SignInWithEmailEvents.Events, metadata: [String : String]) {
        self.name = event.rawValue
        self.metadata = metadata
    }
}
