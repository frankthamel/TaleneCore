//
//  Say.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/12/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

public struct TCSay {
    public struct Alerts {
        public static let success = "Success!"
        public static let error = "Error"
        public static let info = "Info!"
        public static let cancel = "Cancel"
        public static let close = "Close"
        public static let ok = "Ok"

        public static let signIn = "SignIn"
        public static let signUp = "SignUp"

        public static let sign_in_blank_number = "Mobile number cannot be blank."
        public static let sign_in_verification_failed = "Mobile number verification failed."
    }

    public struct Messages {
        public static let hide = "Hide"
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
