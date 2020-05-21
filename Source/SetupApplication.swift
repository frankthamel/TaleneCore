//
//  SetupApplication.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/14/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

public protocol AppConfigure {
    func configure()
}

public func configureTaleneCoreApp() {

    // configure managers
    App.managers.loader.configure()
    App.managers.notification.configure()

    // configure services
    App.services.firebaseService.configure()
    App.services.socialShareService.configure()
}

