//
//  FirebaseRemoteConfigService.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/2/20.
//

import Foundation
import FirebaseRemoteConfig

public typealias AppRemoteConfig = RemoteConfig

public protocol FirebaseRemoteConfigService: AppConfigure {
    var remoteConfig: RemoteConfig { get }
    func setDefaults(fromDictionary dictionary: [String: NSObject])
    func setDefaults(fromPlist plist: String)
}

class FirebaseRemoteConfigServiceProvider: FirebaseRemoteConfigService {

    var remoteConfig: RemoteConfig = RemoteConfig.remoteConfig()

    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval =  TimeInterval(App.settings.configs.lc.firebaseRemoteConfigsFetchInterval ?? 3600)
        remoteConfig.configSettings = settings
    }

    func setDefaults(fromDictionary dictionary: [String: NSObject]) {
        remoteConfig.setDefaults(dictionary)
        TCRun.afterDelay(seconds: 10) {
            self.fetchAndActivate()
        }
    }

    func setDefaults(fromPlist plist: String) {
        remoteConfig.setDefaults(fromPlist: plist)
        TCRun.afterDelay(seconds: 10) {
            self.fetchAndActivate()
        }
    }

    func fetchAndActivate() {
        remoteConfig.fetch(withExpirationDuration: TimeInterval(App.settings.configs.lc.firebaseRemoteConfigsExpirationPeriod ?? 3600)) { (status, error) in
            if status == .success {
                App.managers.logger.info(message: "Successfully fetched remote configs.")
                self.remoteConfig.activate() { (error) in
                    if error != nil {
                        App.managers.logger.error(message: "Error: \(error?.localizedDescription ?? "Config not activate remote configs.")")
                    }
                }
            } else {
                App.managers.logger.error(message: "Error: \(error?.localizedDescription ?? "Config not fetched")")
            }
        }
    }
}
