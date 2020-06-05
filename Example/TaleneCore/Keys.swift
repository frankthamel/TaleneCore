//
//  Keys.swift
//  TaleneCore_Example
//
//  Created by Frank Emmanuel on 6/5/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import TaleneCore

extension AppKeys {
    var paymentGatewayKey: String? {
        return valueForKey(key: "paymentGatewayKey")
    }

}
