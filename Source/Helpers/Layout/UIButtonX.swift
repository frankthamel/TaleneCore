//
//  UIButtonX.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/21/20.
//

import UIKit

open class UIButtonX: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable public var isShadowEnabled: Bool = false {
        didSet {
            layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            if isShadowEnabled {
                layer.shadowColor = shadowColor.cgColor
                layer.shadowRadius = shadowRadius
                layer.shadowOpacity = shadowOpacity
                layer.shadowOffset = shadowOffset
            } else {
                layer.shadowColor = UIColor.clear.cgColor
                layer.shadowRadius = 0
                layer.shadowOpacity = 0
                layer.shadowOffset = .zero
            }
        }
    }

    @IBInspectable public var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }

    @IBInspectable public var shadowRadius: CGFloat = 15 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }

    @IBInspectable public var shadowOpacity: Float = 0.5 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    @IBInspectable public var shadowOffset: CGSize = .zero {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
}
