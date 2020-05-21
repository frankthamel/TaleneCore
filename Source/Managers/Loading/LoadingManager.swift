//
//  LoadingManager.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/14/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation
import ARSLineProgress

public protocol Loader: AppConfigure {
    func show()
    func hide()
    func showSuccess()
    func showFail()
    func cancelPorgressWithFailAnimation(showFail: Bool)
}

struct LoadingManager: Loader {

    func configureLoader() {
        ARSLineProgressConfiguration.backgroundViewColor = App.settings.theme.loaderBackgroundViewColor
        ARSLineProgressConfiguration.backgroundViewStyle = .full
        ARSLineProgressConfiguration.checkmarkColor = App.settings.theme.loaderCheckmarkColor
        ARSLineProgressConfiguration.successCircleColor = App.settings.theme.loaderSuccessCircleColor
        ARSLineProgressConfiguration.failCircleColor = App.settings.theme.loaderFailCircleColor
        ARSLineProgressConfiguration.failCrossColor = App.settings.theme.loaderFailCrossColor
        ARSLineProgressConfiguration.circleColorInner = App.settings.theme.loaderCircleColorInner
        ARSLineProgressConfiguration.circleColorMiddle = App.settings.theme.loaderCircleColorMiddle
        ARSLineProgressConfiguration.circleColorOuter = App.settings.theme.loaderCircleColorOuter
    }

    func configure() {
        configureLoader()
    }

    func show() {
        ARSLineProgress.show()
    }

    func hide() {
        ARSLineProgress.hide()
    }

    func showSuccess() {
        ARSLineProgress.showSuccess()
    }

    func showFail() {
        ARSLineProgress.showFail()
    }

    func cancelPorgressWithFailAnimation(showFail: Bool) {
        ARSLineProgress.cancelProgressWithFailAnimation(showFail)
    }
}


