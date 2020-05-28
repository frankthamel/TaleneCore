//
//  BuyAppCard.swift
//  TaleneCore_Example
//
//  Created by Frank Emmanuel on 5/28/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import TaleneCore

class BuyAppCard: CoreMessageView {
    var cancelAction: (() -> Void)?

    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }

    deinit {
        App.managers.logger.verbose(message: "deinit: BuyAppCard")
    }

    @IBAction func close(_ sender: Any) {
        App.managers.message.hide()
    }


}
