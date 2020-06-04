//
//  ConnectionManager.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/3/20.
//

import Foundation

public protocol Connection {
    func showReachableMesage() -> Bool
    func isReachable() -> Bool
}

struct ConnectionManager: Connection {

    func showReachableMesage() -> Bool {
        let isRechable = App.services.connectionService.isReachable()

        if !isRechable {
            App.managers.message.showMessage(model: MessageModel.noInternet)
        }

        return !isRechable
    }

    func isReachable() -> Bool {
        return App.services.connectionService.isReachable()
    }
}


