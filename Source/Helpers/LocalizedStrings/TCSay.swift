//
//  Say.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/12/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

public class TCSay {
    public struct Alerts {
        public static let success = translation(forKey: "TCSay.Alerts.success", elseString: "Success!")
        public static let error = translation(forKey: "TCSay.Alerts.error", elseString: "Error")
        public static let info = translation(forKey: "TCSay.Alerts.info", elseString: "Info!")
        public static let cancel = translation(forKey: "TCSay.Alerts.cancel", elseString: "Cancel")
        public static let close = translation(forKey: "TCSay.Alerts.close", elseString: "Close")
        public static let ok = translation(forKey: "TCSay.Alerts.ok", elseString: "Ok")

        public static let signIn = translation(forKey: "TCSay.Alerts.signIn", elseString: "SignIn")
        public static let signUp = translation(forKey: "TCSay.Alerts.signUp", elseString: "SignUp")

        public static let signInBlankNumber = translation(forKey: "TCSay.Alerts.signInBlankNumber", elseString: "Mobile number cannot be blank.")
        public static let signInVerificationFailed = translation(forKey: "TCSay.Alerts.signInVerificationFailed", elseString: "Mobile number verification failed.")
    }

    public struct Messages {
        public static let hide = translation(forKey: "TCSay.Messages.hide", elseString: "Hide")
    }

    public struct Authenticator {
        public static let emailPlaceholder = translation(forKey: "TCSay.Authenticator.emailPlaceholder", elseString: "youremail@text.com")
        public static let passwordPlaceHolder = translation(forKey: "TCSay.Authenticator.passwordPlaceHolder", elseString: "Password")
        public static let confirmPasswordPlaceHolder = translation(forKey: "TCSay.Authenticator.confirmPasswordPlaceHolder", elseString: "Type the same password")
        public static let emailVerification = translation(forKey: "TCSay.Authenticator.emailVerification", elseString: "Email verification")
        public static let emailVerificationMessage = translation(forKey:  "TCSay.Authenticator.emailVerificationMessage", elseString: "Email verification sent successfully. Check your email.")
        public static let passwordReset = translation(forKey: "TCSay.Authenticator.passwordReset", elseString: "Password Reset")
        public static let passwordResetMessege = translation(forKey: "TCSay.Authenticator.passwordResetMessege", elseString: "Password Reset sent successfully. Check your email")
        public static let usernameAlreadyTaken = translation(forKey: "TCSay.Authenticator.usernameAlreadyTaken", elseString: "Username already registered. Try again with a new email.")
        public static let signUpfailed = translation(forKey: "TCSay.Authenticator.signUpfailed", elseString: "SignUp failed. Try again.")

    }

    public struct Days {
        public static let all = translation(forKey: "TCSay.Days.all", elseString: "All")
        public static let sunday = translation(forKey: "TCSay.Days.sunday", elseString: "Sunday")
        public static let monday = translation(forKey: "TCSay.Days.monday", elseString: "Monday")
        public static let tuesday = translation(forKey: "TCSay.Days.tuesday", elseString: "Tuesday")
        public static let wednesday = translation(forKey: "TCSay.Days.wednesday", elseString: "Wednesday")
        public static let thursday = translation(forKey: "TCSay.Days.thursday", elseString: "Thursday")
        public static let friday = translation(forKey: "TCSay.Days.friday", elseString: "Friday")
        public static let saturday = translation(forKey: "TCSay.Days.saturday", elseString: "Saturday")
    }

    public struct Notification {
        public static let notificationCreateErrorTitle = translation(forKey: "TCSay.Notification.notificationCreateErrorTitle", elseString: "Can not Schedule this task.")
        public static let notificationCreateErrorSubtitle = translation(forKey: "TCSay.Notification.notificationCreateErrorSubtitle", elseString: "Error occoured while scheduling this task. please try again.")
    }
}

public func translation(forKey key: String, elseString string: String) -> String {
    //return localized/ formatted //// Future implementation
    if App.settings.configs.lc.useProvidedTranslationsForCoreStrings {
        return App.settings.translations.valueForKey(key: key) ?? ""
    } else {
        return string
    }
}
