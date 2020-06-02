//
//  SetupApplication.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/14/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

public protocol AppConfigure {
    func configure<T>(inType type: T, application: UIApplication)
}

public func configureTaleneCoreApp<T>(inType type: T, application: UIApplication) {

    // Reset badge
    UIApplication.shared.applicationIconBadgeNumber = 0

    // configure managers
    App.managers.loader.configure(inType: type, application: application)
    App.managers.notification.configure(inType: type, application: application)

    // configure services
    App.services.firebaseService.configure(inType: type, application: application)
    App.services.socialShareService.configure(inType: type, application: application)

    // configure store
    App.settings.configs.configure(inType: type, application: application)

}

