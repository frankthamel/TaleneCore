//
//  LocalConfigs.swift
//  TaleneCore_Example
//
//  Created by Frank Emmanuel on 6/5/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import TaleneCore

extension LocalConfigStore {
    var developerDetails: Developer? {
        return valueForKey(key: "developerDetails")
    }
}

struct Developer: Codable {
    let name: String
    let email: String
}

