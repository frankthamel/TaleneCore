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
    public let context = AppContext()
    public let services = Services()
    public let internalServices = InternalServices()
    public let managers = Managers()
    public let store = Store()
    public let settings = Settings()
}

public struct Services {
    public let firebaseService: FirebaseService = FirebaseServiceProvider()
    public let socialShareService: SocialShareService = SocialShareServiceProvider()
    public let zip: Zip = ZipServiceProvider()
    public let keychain: KeychainService = KeychainServiceProvider()
    public let connectionService: ConnectionService = ConnectionServiceProvider()
}

public struct InternalServices {
    // auto authenticator with duration
}

public struct Managers {
    public let alert: Alert = AlertManager()
    public let message: Message = MessageManager()
    public let analytics: AnalyticsEngine = AnalyticsManager()
    public let logger: Logger = LoggingManager()
    public let authenticator: Authentication = AuthenticationManager()
    public let loader: Loader = LoadingManager()
    public let phoneNumber: PhoneNumber = PhoneNumberManager()
    public let notification: Notification = NotificationManager()
    public let hapticFeedback: FeedbackGenerator = HapticFeedbackManager()
    public let connection: Connection = ConnectionManager()
    public let file: FileHandling = TCFileManager()
    public let keychain: Keychain = KeychainManager()
    //let parentalGate
    //let link

}

public struct Store {
    public let mainBundle: TCAppMainBundle = TCAppMainBundleProvider()
    public let userDefaults: UserDefaultsStore = UserDefaultsStoreProvider()
    public let db: Database = RealmDatabase()
}

public struct Settings {
    public let theme: Theme = AppTheme()
    public let urls = ApplicationUrls()
    public let keys = AppKeys()
    public let configs: Configs = ConfigStore()
    public let translations = Translations()
}
