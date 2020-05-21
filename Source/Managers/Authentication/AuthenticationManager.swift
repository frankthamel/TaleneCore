//
//  AuthenticationManager.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/13/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

public protocol Authentication {
    // setup authentication service
//    func signIn(withCredetials: Credencial)
//    func logout()
//    func isUserLoggedIn() -> Bool
//    func isAuthenticated() -> Bool

    func verifyPhoneNumber(number: String, withCompletion completion: @escaping (Result<String, PhoneNumberVarificationError>) -> Void)
    func signIn(withVerificationCode verificationCode: String, withCompletion completion: @escaping (Result<String, UserAuthenticationError>) -> Void)

}

struct AuthenticationManager: Authentication {
    let localAuthenticator: Authentication = LocalAuthenticator()
    let remoteAuthenticator: Authentication = RemoteAuthenticator()

    func verifyPhoneNumber(number: String, withCompletion completion: @escaping (Result<String, PhoneNumberVarificationError>) -> Void) {
        remoteAuthenticator.verifyPhoneNumber(number: number, withCompletion: completion)
    }

    func signIn(withVerificationCode verificationCode: String, withCompletion completion: @escaping (Result<String, UserAuthenticationError>) -> Void) {
        remoteAuthenticator.signIn(withVerificationCode: verificationCode, withCompletion: completion)
    }

}
