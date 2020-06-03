//
//  Connection.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/3/20.
//

import Foundation
import Reachability

public protocol ConnectionService {
    func isReachable() -> Bool
}

struct ConnectionServiceProvider: ConnectionService {

    func isReachable() -> Bool {
        let reachability = try? Reachability()
        if let reachabilityConnetion = reachability {
            return reachabilityConnetion.connection == .unavailable ? false : true
        } else {
            return false
        }
    }
}
