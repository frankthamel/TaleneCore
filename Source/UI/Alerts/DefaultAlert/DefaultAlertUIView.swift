//
//  SuccessAlertUIView.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/12/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import UIKit

public class DefaultAlertUIView: UIView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var containerView: UIViewX!
    @IBOutlet weak var layerMaskView: UIView!

    public class func instantiateFromNib() -> DefaultAlertUIView {
        return App.store.mainBundle.getAppBundle().loadNibNamed("DefaultAlertUIView", owner: self, options: nil)!.first as! DefaultAlertUIView
    }

}
