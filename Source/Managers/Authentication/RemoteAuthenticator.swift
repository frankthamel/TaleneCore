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
    
    func signIn(withCredential credential: Credential, withCompletion completion: @escaping (Result<User, UserAuthenticationError>) -> Void) {
        if credential.isFirebase {
            App.services.firebaseService.firebaseAuthenticationService.signIn(withCredential: credential) { result in
                switch result {
                case .success(let firebaseUser):
                    completion(.success(firebaseUser.toUser()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func signUp(withCredentials credentials: Credential, withCompletion completion: @escaping (Result<User, UserAuthenticationError>) -> Void) {
        if credentials.isFirebase {
            App.services.firebaseService.firebaseAuthenticationService.signUp(withCredentials: credentials) { result in
                switch result {
                case .success(let firebaseUser):
                    completion(.success(firebaseUser.toUser()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func signOut(withCompletion completion: @escaping (Result<String, UserAuthenticationError>) -> Void) {
        App.services.firebaseService.firebaseAuthenticationService.signOut(withCompletion: completion)
    }

    func sendVerificationEmail(withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void) {
        App.services.firebaseService.firebaseAuthenticationService.sendVerificationEmail(withCompletion: completion)
    }

    func forgotPassword(forEmail email: String, withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void) {
        App.services.firebaseService.firebaseAuthenticationService.forgotPassword(forEmail: email, withCompletion: completion)
    }

    func updatePassword(withCredential credential: Credential, withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void) {
        App.services.firebaseService.firebaseAuthenticationService.updatePassword(withCredential: credential, withCompletion: completion)
    }

    func reauthenticate(withCredential credential: Credential, withCompletion completion: @escaping (Result<User, UserAuthenticationError>) -> Void) {
        App.services.firebaseService.firebaseAuthenticationService.reauthenticate(withCredential: credential) { result in
            switch result {
            case .success(let firebaseUser):
                completion(.success(firebaseUser.toUser()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getCurrentUser() -> User? {
        if let firebaseUser = App.services.firebaseService.firebaseAuthenticationService.getCurrentUser() {
            return firebaseUser.toUser()
        } else {
            return nil
        }
    }

}
