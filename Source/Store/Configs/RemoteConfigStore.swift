//
//  RemoteConfigStore.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/2/20.
//

import Foundation

public class RemoteAppConfigs {

    public lazy var remoteConfig: AppRemoteConfig = {
        return App.services.firebaseService.firebaseRemoteConfigService.remoteConfig
    }()

    public func configure<T>(inType type: T, application: UIApplication) {}

    public func setDefaults(fromDictionary dictionary: [String: NSObject]) {
        App.services.firebaseService.firebaseRemoteConfigService.setDefaults(fromDictionary: dictionary)
    }

    public func setDefaults(fromPlist plist: String) {
        App.services.firebaseService.firebaseRemoteConfigService.setDefaults(fromPlist: plist)
    }
}
