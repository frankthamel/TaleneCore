//
//  LocalConfigStore.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/5/20.
//

import Foundation
import SwiftyJSON

public class LocalConfigStore: AppConfigure {

    var configs: [String: AnyObject]?

    public func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        configs = App.managers.file.readPlist(name: "LocalConfigs")
    }

    public func valueForKey<T: Codable>(key: String) -> T? {
        guard let data = configs else {
            return nil
        }

        guard let json = JSON(data)[key].string else { return nil }
        let decodedObj: T? = try? TCEncodeDecode.decode(string: json)
        return decodedObj ?? json as? T
    }

}

public extension LocalConfigStore {

    var messageDisplayTime: Int? {
        return valueForKey(key: "messageDisplayTime")
    }

    var useProvidedTranslationsForCoreStrings: Bool {
        let valueString: String? = valueForKey(key: "useProvidedTranslationsForCoreStrings")
        guard let value = valueString else { return false }
        return value == "true" ? true : false
    }

    var firebaseRemoteConfigsFetchInterval: Int? {
        return valueForKey(key: "firebaseRemoteConfigsFetchInterval")
    }

    var firebaseRemoteConfigsExpirationPeriod: Int? {
        return valueForKey(key: "firebaseRemoteConfigsExpirationPeriod")
    }

    var preferredStatusBarStyle: UIStatusBarStyle {
        let value: String? = valueForKey(key: "preferredStatusBarStyle")
        guard let stringValue = value else {
            return .default
        }

        if stringValue == "light" {
            return .lightContent
        } else {
            return .default
        }
    }
}
