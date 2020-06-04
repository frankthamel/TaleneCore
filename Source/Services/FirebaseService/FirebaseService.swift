//
//  FirebaseService.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/13/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseAnalytics

public protocol FirebaseService: AppConfigure {
    var firebaseAuthenticationService: FirebaseAuthenticationService { get set }
    var firebaseAnalyticsService: FirebaseAnalyticsService { get set }
    var firebasePushNotificationService: FirebasePushNotificationService { get set }
    var firebaseRemoteConfigService: FirebaseRemoteConfigService { get set }
}

struct FirebaseServiceProvider: FirebaseService {
    var firebaseAuthenticationService: FirebaseAuthenticationService = FirebaseAuthenticationServiceProvider()
    var firebaseAnalyticsService: FirebaseAnalyticsService = FirebaseAnalyticsServiceProvider()
    var firebasePushNotificationService: FirebasePushNotificationService = FirebasePushNotificationServiceProvider()
    var firebaseRemoteConfigService: FirebaseRemoteConfigService = FirebaseRemoteConfigServiceProvider()

    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        firebasePushNotificationService.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)
        firebaseRemoteConfigService.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)
    }

}


