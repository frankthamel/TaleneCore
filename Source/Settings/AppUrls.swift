//
//  AppUrls.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/14/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ApplicationUrls: AppConfigure {
    var urls: [String: AnyObject]?

    public func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        urls = App.managers.file.readPlist(name: "Urls")
    }

    public var appUrl: String? {
        return valueForKey(key: "appUrl")
    }

    public func valueForKey(key: String) -> String? {
        guard let data = urls else {
            return nil
        }

        let json = JSON(data)
        return json[key].string
    }
}

