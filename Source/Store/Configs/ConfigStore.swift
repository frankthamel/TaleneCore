//
//  ConfigStore.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/2/20.
//

import Foundation

public protocol Configs: AppConfigure {
    var rc: RemoteAppConfigs { get set }
}

class ConfigStore: Configs {
    var rc = RemoteAppConfigs()

    func configure<T>(inType type: T, application: UIApplication) {
        rc.configure(inType: type, application: application)
    }
}
