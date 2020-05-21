//
//  TCAppMainBundle.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/21/20.
//

import Foundation

public protocol TCAppMainBundle {
    func getAppBundle() -> Bundle
}

struct TCAppMainBundleProvider: TCAppMainBundle {
    func getAppBundle() -> Bundle {
        let frameworkBundle = Bundle(for: TaleneCoreApp.self)
        let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("TaleneCore.bundle")

        guard let url = bundleURL else {
            return Bundle.main
        }

        return Bundle(url: url) ?? Bundle.main
    }
}
