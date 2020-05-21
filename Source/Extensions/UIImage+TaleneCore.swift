//
//  UIImage+TaleneCore.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/21/20.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(withFrameworkName: String) {
        let path = App.store.mainBundle.getAppBundle().path(forResource: withFrameworkName, ofType: "png")
        self.init(contentsOfFile: path ?? "")
    }
}

