//
//  ConfigStore.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/2/20.
//

import Foundation

public protocol Configs: AppConfigure {
    var rc: RemoteAppConfigs { get set }
    var lc: LocalConfigStore { get set }
}

class ConfigStore: Configs {
    var rc = RemoteAppConfigs()
    var lc = LocalConfigStore()

    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        rc.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)
        lc.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)
    }
}
