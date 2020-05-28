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

    //TODO: Should load from a json file
    // App

    public var navigationBarColor: UIColor = UIColor(red: 23/255, green: 25/255, blue: 44/255, alpha: 1)

    public var tabBarColor: UIColor = UIColor(red: 23/255, green: 25/255, blue: 44/255, alpha: 1)

    public var backgroundColor: UIColor = UIColor(red: 41/255, green: 44/255, blue: 78/255, alpha: 1)

    public var homeViewMainCardColor: UIColor = UIColor(red: 33/255, green: 33/255, blue: 34/255, alpha: 1)

    public var homeViewBookmarkCardColor: UIColor = UIColor(red: 28/255, green: 31/255, blue: 56/255, alpha: 1)

    public var subColorOne: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)

    public var subColorTwo: UIColor = UIColor.white

    public var subColorThree: UIColor = UIColor.white

    public var subColorFour: UIColor = UIColor.white

    public var subColorFive: UIColor = UIColor.white

    // Text Fields

    var textFieldBorderColorLight: UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)

    var textFieldBackgroundColorLight: UIColor = UIColor.white

    var textFieldPlaceholder: UIColor = UIColor(red: 0.71, green: 0.72, blue: 0.72, alpha: 1.00)

    var textFieldError: UIColor = UIColor(red: 1.00, green: 0.20, blue: 0.20, alpha: 1.00)

    // Alerts

    public var successColor: UIColor = UIColor(red: 59/255, green: 195/255, blue: 116/255, alpha: 1)

    public var falierColor: UIColor = UIColor(red: 195/255, green: 59/255, blue: 59/255, alpha: 1)

    public var infoColor: UIColor = UIColor(red: 1.00, green: 0.79, blue: 0.00, alpha: 1.00)

    public var primaryActionColor: UIColor = UIColor(red: 104/255, green: 118/255, blue: 251/255, alpha: 1)

    public var secondaryActionColor: UIColor = UIColor(red: 0.28, green: 0.28, blue: 0.28, alpha: 1.00)

    public var foregroundColor: UIColor = UIColor.white

    public var foregroundContrastColor: UIColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)

    // Loadder

    public var loaderBackgroundViewColor: CGColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor

    public var loaderCheckmarkColor: CGColor = UIColor.white.cgColor

    public var loaderSuccessCircleColor: CGColor = UIColor(red: 138/255, green: 1, blue: 129/255, alpha: 1).cgColor

    public var loaderFailCircleColor: CGColor = UIColor(red: 1, green: 70/255, blue: 70/255, alpha: 1).cgColor

    public var loaderFailCrossColor: CGColor = UIColor(red: 1, green: 70/255, blue: 70/255, alpha: 1).cgColor

    public var loaderCircleColorInner: CGColor = UIColor(red: 7/255, green: 207/255, blue: 1, alpha: 1).cgColor

    public var loaderCircleColorMiddle: CGColor = UIColor.white.cgColor

    public var loaderCircleColorOuter: CGColor = UIColor(red: 7/255, green: 207/255, blue: 1, alpha: 1).cgColor

}
