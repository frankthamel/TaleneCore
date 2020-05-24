//
//  AuthenticationManager.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/13/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

public protocol Authentication {
    func verifyPhoneNumber(number: String, withCompletion completion: @escaping (Result<String, PhoneNumberVarificationError>) -> Void)
    func signIn(withVerificationCode verificationCode: String, withCompletion completion: @escaping (Result<String, UserAuthenticationError>) -> Void)
    func signIn(withCredential credential: Credential, withCompletion completion: @escaping (Result<User, UserAuthenticationError>) -> Void)
    func signUp(withCredentials credentials: Credential, withCompletion completion: @escaping (Result<User, UserAuthenticationError>) -> Void)
    func signOut(withCompletion completion: @escaping (Result<String, UserAuthenticationError>) -> Void)
    func sendVerificationEmail(withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void)
    func forgotPassword(forEmail email: String, withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void)
    func updatePassword(withCredential credential: Credential, withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void)
    func reauthenticate(withCredential credential: Credential, withCompletion completion: @escaping (Result<User, UserAuthenticationError>) -> Void)
    func getCurrentUser() -> User?
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

    func signIn(withCredential credential: Credential, withCompletion completion: @escaping (Result<User, UserAuthenticationError>) -> Void) {
        remoteAuthenticator.signIn(withCredential: credential, withCompletion: completion)
    }

    func signUp(withCredentials credentials: Credential, withCompletion completion: @escaping (Result<User, UserAuthenticationError>) -> Void) {
        remoteAuthenticator.signUp(withCredentials: credentials, withCompletion: completion)
    }

    func signOut(withCompletion completion: @escaping (Result<String, UserAuthenticationError>) -> Void) {
        remoteAuthenticator.signOut(withCompletion: completion)
    }

    func sendVerificationEmail(withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void) {
        remoteAuthenticator.sendVerificationEmail(withCompletion: completion)
    }

    func forgotPassword(forEmail email: String, withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void) {
        remoteAuthenticator.forgotPassword(forEmail: email, withCompletion: completion)
    }

    func updatePassword(withCredential credential: Credential, withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void) {
        remoteAuthenticator.updatePassword(withCredential: credential, withCompletion: completion)
    }

    func reauthenticate(withCredential credential: Credential, withCompletion completion: @escaping (Result<User, UserAuthenticationError>) -> Void) {
        remoteAuthenticator.reauthenticate(withCredential: credential, withCompletion: completion)
    }

    func getCurrentUser() -> User? {
        remoteAuthenticator.getCurrentUser()
    }

}
