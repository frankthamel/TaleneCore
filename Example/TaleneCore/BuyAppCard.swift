//
//  BuyAppCard.swift
//  TaleneCore_Example
//
//  Created by Frank Emmanuel on 5/28/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import SwiftMessages
import TaleneCore

class BuyAppCard: MessageView {
    var cancelAction: (() -> Void)?

    deinit {
        App.managers.logger.verbose(message: "deinit: BuyAppCard")
    }
}
