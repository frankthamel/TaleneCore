//
//  RemoteAuthenticator.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/13/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

struct RemoteAuthenticator: Authentication {
    func verifyPhoneNumber(number: String, withCompletion completion: @escaping (Result<String, PhoneNumberVarificationError>) -> Void) {
        App.services.firebaseService.firebaseAuthenticationService.verifyPhoneNumber(phoneNumber: number, withCompletion: completion)
    }

    func signIn(withVerificationCode verificationCode: String, withCompletion completion: @escaping (Result<String, UserAuthenticationError>) -> Void) {
        App.services.firebaseService.firebaseAuthenticationService.signIn(withVerificationCode: verificationCode, withCompletion: completion)
    }
}
