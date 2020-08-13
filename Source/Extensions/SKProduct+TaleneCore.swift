//
//  SKProduct+TaleneCore.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 8/13/20.
//

import Foundation
import StoreKit

public extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price) ?? "\(price)"
    }
}
