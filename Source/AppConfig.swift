//
//  AppConfig.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/11/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

public let App = AppConfig()

public struct AppConfig {
    public let services = Services()
    //let inter
    public let managers = Managers()
    public let store = Store()
    public let settings = Settings()
}

public struct Services {
    public let firebaseService: FirebaseService = FirebaseServiceProvider()
    public let socialShareService: SocialShareService = SocialShareServiceProvider()
}

public struct InternalServices {
    // auto authenticator with duration
}

public struct Managers {
    public let alert: Alert = AlertManager()
    //let toast
    public let analytics: AnalyticsEngine = AnalyticsManager()
    public let logger: Logger = LoggingManager()
    public let authenticator: Authentication = AuthenticationManager()
    public let loader: Loader = LoadingManager()
    public let phoneNumber: PhoneNumber = PhoneNumberManager()
    public let notification: Notification = NotificationManager()
    public let hapticFeedback: FeedbackGenerator = HapticFeedbackManager()
    //let connection:
    //let file
    //let keychain
    //let parentalGate
    //let link

}

public struct Store {
    public let mainBundle: TCAppMainBundle = TCAppMainBundleProvider()
    public let userDefaults: UserDefaultsStore = UserDefaultsStoreProvider()
    //let database
}

public struct Settings {
    //TODO: Local configs should load from json files
    public let theme: Theme = AppTheme()
    public let urls: AppUrls = ApplicationUrls()
    public let keys: Keys = AppKeys()
    public let appSetings: AppSettings = AppSettingsBase()
    
}
