//
//  KeyboardManager.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 7/31/20.
//

import Foundation
import IQKeyboardManagerSwift

public protocol Keyboard: AppConfigure {

}

class KeyboardManager: Keyboard {
    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        IQKeyboardManager.shared.enable = true
    }
}
