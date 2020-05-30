//
//  TCAdsEvents.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/30/20.
//

import Foundation

struct TCAdsEvents: AnalyticsEvent {

    var name: String

    var metadata: [String : String]?

    enum Events: String {
        case screenSetup = "TCAds_Alert_Loaded"
        case shareClick = "TCAds_Share_Button_Click"
        case share = "TCAds_Share"
    }
}

extension TCAdsEvents {
    init(_ event: TCAdsEvents.Events) {
        self.name = event.rawValue
    }

    init(_ event: TCAdsEvents.Events, metadata: [String : String]) {
        self.name = event.rawValue
        self.metadata = metadata
    }
}
