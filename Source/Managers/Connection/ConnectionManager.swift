//
//  ConnectionManager.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/3/20.
//

import Foundation

public protocol Connection {
    func isReachable() -> Bool
}

struct ConnectionManager: Connection {
    func isReachable() -> Bool {
        return App.services.connectionService.isReachable()
    }
}


