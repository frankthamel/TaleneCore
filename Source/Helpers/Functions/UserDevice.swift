//
//  UserDevice.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 7/8/20.
//

import Foundation

public struct UserDevice {
    public static func deviceID() -> String {
        guard let deviceID = UIDevice.current.identifierForVendor?.uuidString else {
           return ""
        }
        return deviceID
    }
}
