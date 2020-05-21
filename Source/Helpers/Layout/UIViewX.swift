//
//  UIViewX.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/12/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import UIKit

@IBDesignable
public class UIViewX: UIView {

    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

}
