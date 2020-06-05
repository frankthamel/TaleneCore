//
//  Keys.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/14/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation
import SwiftyJSON

public class AppKeys: AppConfigure {
    var keys: [String: AnyObject]?

    public func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        keys = App.managers.file.readPlist(name: "Keys")
    }

    public var adsAppId: String? {
        return valueForKey(key: "adsAppId")
    }

    public var bannerAdsID: String? {
        return valueForKey(key: "bannerAdsID")
    }

    public var videoAdsID: String? {
        return valueForKey(key: "videoAdsID")
    }

    public func valueForKey(key: String) -> String? {
        guard let data = keys else {
            return nil
        }

        let json = JSON(data)
        return json[key].string
    }
}
