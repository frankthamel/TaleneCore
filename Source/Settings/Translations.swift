//
//  Translations.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/7/20.
//

import Foundation
import SwiftyJSON

public class Translations: AppConfigure {
    var translations: TCJSON?

    public func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        translations = App.managers.file.readJSON(fileName: "Translations")
        //readPlist(name: "Translations")
    }

    public func valueForKey(key: String) -> String? {
        guard let json = translations else {
            return nil
        }

        return json[key].string
    }
}
