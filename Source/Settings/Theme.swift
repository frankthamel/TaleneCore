//
//  Theme.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/14/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import UIKit

public protocol Theme {

    // App
    var navigationBarColor: UIColor { get set }
    var tabBarColor: UIColor { get set }
    var backgroundColor: UIColor { get set }
    var homeViewMainCardColor: UIColor { get set }
    var homeViewBookmarkCardColor: UIColor { get set }
    var subColorOne: UIColor { get set }
    var subColorTwo: UIColor { get set }
    var subColorThree: UIColor { get set }
    var subColorFour: UIColor { get set }
    var subColorFive: UIColor { get set }

    // Text Fields
    var textFieldBorderColorLight: UIColor { get set }
    var textFieldBackgroundColorLight: UIColor { get set }
    var textFieldPlaceholder: UIColor { get set }
    var textFieldError: UIColor { get set }

    // Alerts
    var successColor: UIColor { get set }
    var falierColor: UIColor { get set }
    var infoColor: UIColor { get set }
    var primaryActionColor: UIColor { get set }
    var secondaryActionColor: UIColor { get set }
    var foregroundColor: UIColor { get set }
    var foregroundContrastColor: UIColor { get set }

    // Loadder
    var loaderBackgroundViewColor: CGColor { get set }
    var loaderCheckmarkColor: CGColor { get set }
    var loaderSuccessCircleColor: CGColor { get set }
    var loaderFailCircleColor: CGColor { get set }
    var loaderFailCrossColor: CGColor { get set }
    var loaderCircleColorInner: CGColor { get set }
    var loaderCircleColorMiddle: CGColor { get set }
    var loaderCircleColorOuter: CGColor { get set }

}

struct AppTheme: Theme {

    // App

    public var navigationBarColor: UIColor = {
        return UIColor(named: "navigationBarColor") ?? UIColor.black
    }()

    public var tabBarColor: UIColor = {
        return UIColor(named: "tabBarColor") ?? UIColor.black
    }()

    public var backgroundColor: UIColor = {
        return UIColor(named: "backgroundColor") ?? UIColor.gray
    }()

    public var homeViewMainCardColor: UIColor = {
        return UIColor(named: "homeViewMainCardColor") ?? UIColor.black
    }()

    public var homeViewBookmarkCardColor: UIColor = {
        return UIColor(named: "homeViewBookmarkCardColor") ?? UIColor.black
    }()

    public var subColorOne: UIColor = {
        return UIColor(named: "subColorOne") ?? UIColor.black
    }()

    public var subColorTwo: UIColor = {
        return UIColor(named: "subColorTwo") ?? UIColor.black
    }()

    public var subColorThree: UIColor = {
        return UIColor(named: "subColorThree") ?? UIColor.black
    }()

    public var subColorFour: UIColor = {
        return UIColor(named: "subColorFour") ?? UIColor.black
    }()

    public var subColorFive: UIColor = {
        return UIColor(named: "subColorFive") ?? UIColor.black
    }()

    // Text Fields

    var textFieldBorderColorLight: UIColor = {
        return UIColor(named: "textFieldBorderColorLight") ?? UIColor.black
    }()

    var textFieldBackgroundColorLight: UIColor = {
        return UIColor(named: "textFieldBackgroundColorLight") ?? UIColor.white
    }()

    var textFieldPlaceholder: UIColor = {
        return UIColor(named: "textFieldPlaceholder") ?? UIColor.gray
    }()

    var textFieldError: UIColor = {
        return UIColor(named: "textFieldError") ?? UIColor.black
    }()

    // Alerts

    public var successColor: UIColor = {
        return UIColor(named: "successColor") ?? UIColor.gray
    }()

    public var falierColor: UIColor = {
        return UIColor(named: "falierColor") ?? UIColor.gray
    }()

    public var infoColor: UIColor = {
        return UIColor(named: "infoColor") ?? UIColor.gray
    }()

    public var primaryActionColor: UIColor = {
        return UIColor(named: "primaryActionColor") ?? UIColor.black
    }()

    public var secondaryActionColor: UIColor = {
        return UIColor(named: "secondaryActionColor") ?? UIColor.black
    }()

    public var foregroundColor: UIColor = {
        return UIColor(named: "foregroundColor") ?? UIColor.black
    }()

    public var foregroundContrastColor: UIColor = {
        return UIColor(named: "foregroundContrastColor") ?? UIColor.black
    }()

    // Loadder

    public var loaderBackgroundViewColor: CGColor = {
        return UIColor(named: "loaderBackgroundViewColor")?.cgColor ?? UIColor.black.cgColor
    }()

    public var loaderCheckmarkColor: CGColor = {
        return UIColor(named: "loaderCheckmarkColor")?.cgColor ?? UIColor.white.cgColor
    }()

    public var loaderSuccessCircleColor: CGColor = {
        return UIColor(named: "loaderSuccessCircleColor")?.cgColor ?? UIColor.white.cgColor
    }()

    public var loaderFailCircleColor: CGColor = {
        return UIColor(named: "loaderFailCircleColor")?.cgColor ?? UIColor.white.cgColor
    }()
    public var loaderFailCrossColor: CGColor = {
        return UIColor(named: "loaderFailCrossColor")?.cgColor ?? UIColor.white.cgColor
    }()

    public var loaderCircleColorInner: CGColor = {
        return UIColor(named: "loaderCircleColorInner")?.cgColor ?? UIColor.white.cgColor
    }()

    public var loaderCircleColorMiddle: CGColor = {
        return UIColor(named: "loaderCircleColorMiddle")?.cgColor ?? UIColor.gray.cgColor
    }()

    public var loaderCircleColorOuter: CGColor = {
        return UIColor(named: "loaderCircleColorOuter")?.cgColor ?? UIColor.white.cgColor
    }()

}
