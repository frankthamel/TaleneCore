//
//  Translations.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/7/20.
//

import Foundation
import SwiftyJSON

public class Translations: AppConfigure {
    var translations: [String: AnyObject]?

    public func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        translations = App.managers.file.readPlist(name: "Translations")
    }

    public func valueForKey(key: String) -> String? {
        guard let data = translations else {
            return nil
        }

        let json = JSON(data)
        return json[key].string
    }
}
