//
//  LocalAuthenticator.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/13/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

struct LocalAuthenticator: Authentication {

    func verifyPhoneNumber(number: String, withCompletion completion: @escaping (Result<String, PhoneNumberVarificationError>) -> Void) {

    }

    func signIn(withVerificationCode verificationCode: String, withCompletion completion: @escaping (Result<String, UserAuthenticationError>) -> Void) {
        
    }

    func signIn(withCredential credential: Credential, withCompletion completion: @escaping (Result<User, UserAuthenticationError>) -> Void) {
        
    }

    func signUp(withCredentials credentials: Credential, withCompletion completion: @escaping (Result<User, UserAuthenticationError>) -> Void) {

    }

    func signOut(withCompletion completion: @escaping (Result<String, UserAuthenticationError>) -> Void) {
        
    }

    func sendVerificationEmail(withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void) {

    }

    func forgotPassword(forEmail email: String, withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void) {

    }

    func updatePassword(withCredential credential: Credential, withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void) {

    }

    func reauthenticate(withCredential credential: Credential, withCompletion completion: @escaping (Result<User, UserAuthenticationError>) -> Void) {

    }

    func getCurrentUser() -> User? {
        return nil
    }

}
