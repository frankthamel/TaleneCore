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
        public static let emailPlaceholder = "youremail@text.com"
        public static let passwordPlaceHolder = "Password"
        public static let confirmPasswordPlaceHolder = "Type the same password"
        public static let emailVerification = "Email verification"
        public static let emailVerificationMessage = "Email verification sent successfully. Check your email."
        public static let passwordReset = "Password Reset"
        public static let passwordResetMessege = "Password Reset sent successfully. Check your email"
        public static let usernameAlreadyTaken = "Username already registered. Try again with a new email."
        public static let signUpfailed = "SignUp failed. Try again."

    }

    public struct Days {
        public static let all = "All"
        public static let sunday = "Sunday"
        public static let monday = "Monday"
        public static let tuesday = "Tuesday"
        public static let wednesday = "Wednesday"
        public static let thursday = "Thursday"
        public static let friday = "Friday"
        public static let saturday = "Saturday"
    }

    public struct Notification {
        public static let notificationCreateErrorTitle = "Can not Schedule this task."
        public static let notificationCreateErrorSubtitle = "Error occoured while scheduling this task. please try again."
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
