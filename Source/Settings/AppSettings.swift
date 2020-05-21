//
//  AppSettings.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/14/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

public protocol AppSettings {

}

public protocol LocalAppSettings {

}

public protocol RemoteAppSettings {

}

struct LocalAppSettingsImpl: LocalAppSettings {

}

struct RemoteAppSettingsImpl: RemoteAppSettings {

}

struct AppSettingsBase: AppSettings {
    let localAppSettings: LocalAppSettings = LocalAppSettingsImpl()
    let remoteAppSettings: RemoteAppSettings = RemoteAppSettingsImpl()


}
