//
//  SetupApplication.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/14/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

public protocol AppConfigure {
    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
}

public func configureTaleneCoreApp<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {

    // Reset badge
    UIApplication.shared.applicationIconBadgeNumber = 0

    // configure settings
    App.settings.keys.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)
    App.settings.urls.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)
    App.settings.configs.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)
    App.settings.translations.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)

    // configure store
    App.store.db.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)

    // configure managers
    App.managers.loader.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)
    App.managers.notification.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)

    // configure services
    App.services.firebaseService.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)
    App.services.socialShareService.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)

}

