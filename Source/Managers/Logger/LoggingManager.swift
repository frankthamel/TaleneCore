//
//  LoggingManager.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/13/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation
import SwiftyBeaver

public protocol Logger {
    func debug<T>(message: T)
    func info<T>(message: T)
    func error<T>(message: T)
    func warning<T>(message: T)
    func verbose<T>(message: T)
}

struct LoggingManager: Logger {

    let log = SwiftyBeaver.self
    let console = ConsoleDestination()
    let file = FileDestination()

    init() {
        log.addDestination(console)
        log.addDestination(file)
    }

    func debug<T>(message: T) {
        log.debug(message)
    }

    func info<T>(message: T) {
        log.info(message)
    }

    func error<T>(message: T) {
        log.error(message)
    }

    func warning<T>(message: T) {
        log.warning(message)
    }

    func verbose<T>(message: T) {
        log.verbose(message)
    }
}
