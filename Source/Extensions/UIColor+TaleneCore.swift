//
//  UIColor+TaleneCore.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/25/20.
//

import Foundation

extension UIColor {
    func hashStringToColor(hash: String) -> UIColor {
        let hash: Int = hash.hashValue
        let r: Int = (hash & 0xFF0000) >> 16
        let g: Int = (hash & 0x00FF00) >> 8
        let b: Int = (hash & 0x0000FF)
        return UIColor(red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255), alpha: 1)
    }
}
