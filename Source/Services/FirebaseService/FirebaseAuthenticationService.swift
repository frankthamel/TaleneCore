//
//  FirebaseAuthenticationService.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/13/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation
import FirebaseAuth

public protocol FirebaseAuthenticationService {
    func verifyPhoneNumber(phoneNumber: String, withCompletion completion: @escaping (Result<String, PhoneNumberVarificationError>) -> Void)
    func signIn(withVerificationCode verificationCode: String, withCompletion completion: @escaping (Result<String, UserAuthenticationError>) -> Void)
    func signIn(withCredential credential: Credential, withCompletion completion: @escaping (Result<String, UserAuthenticationError>) -> Void)
}

public enum PhoneNumberVarificationError: Error {
    case verificationFailed(String)
    case nilVerificationId
}

public enum UserAuthenticationError: Error {
    case authError(Int)
    case authResultError
}

struct FirebaseAuthenticationServiceProvider: FirebaseAuthenticationService {
    func verifyPhoneNumber(phoneNumber: String, withCompletion completion: @escaping (Result<String, PhoneNumberVarificationError>) -> Void) {
        // TODO: save phone number to user releam db
        App.store.userDefaults.save(value: phoneNumber, forKey: UserDefaultKeys.userMobileNumber.key())
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                App.managers.logger.error(message: error.localizedDescription)
                completion(.failure(.verificationFailed(error.localizedDescription)))
                return
            }

            if let verificationID = verificationID {
                App.store.userDefaults.save(value: verificationID, forKey: UserDefaultKeys.verificationID.key())
                completion(.success(verificationID))
            } else {
                App.managers.logger.error(message: error?.localizedDescription ?? "nil VerificationId Error")
                completion(.failure(.nilVerificationId))
            }
        }
    }

    func signIn(withVerificationCode verificationCode: String, withCompletion completion: @escaping (Result<String, UserAuthenticationError>) -> Void ) {

        guard let verificationID: String = App.store.userDefaults.getValue(forKey: UserDefaultKeys.verificationID.key()) else {
            return
        }

        let credential = PhoneAuthProvider.provider().credential( withVerificationID: verificationID, verificationCode: verificationCode)

        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                let authError = error as NSError
                completion(.failure(.authError(authError.code)))
                return
            }

            guard let result = authResult else {
                completion(.failure(.authResultError))
                return
            }

            print(result.user.phoneNumber ?? 0)
            completion(.success("Success"))
        }
    }

    func signIn(withCredential credential: Credential, withCompletion completion: @escaping (Result<String, UserAuthenticationError>) -> Void) {
        //completion(.failure(UserAuthenticationError.authResultError))
        completion(.success("Success"))
    }

}
