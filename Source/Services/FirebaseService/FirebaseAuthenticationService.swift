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
    func signIn(withCredential credential: Credential, withCompletion completion: @escaping (Result<FirebaseUser, UserAuthenticationError>) -> Void)
    func signUp(withCredentials credentials: Credential, withCompletion completion: @escaping (Result<FirebaseUser, UserAuthenticationError>) -> Void)
    func signOut(withCompletion completion: @escaping (Result<String, UserAuthenticationError>) -> Void)
    func sendVerificationEmail(withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void)
    func forgotPassword(forEmail email: String, withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void)
    func updatePassword(withCredential credential: Credential, withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void)
    func reauthenticate(withCredential credential: Credential, withCompletion completion: @escaping (Result<FirebaseUser, UserAuthenticationError>) -> Void)
    func getCurrentUser() -> FirebaseUser?
}

public enum PhoneNumberVarificationError: Error {
    case verificationFailed(String)
    case nilVerificationId
}

public enum UserAuthenticationError: Error {
    case authError(Int)
    case authResultError
    case loginFailed(message: String)
    case signUpFailed(message: String)
    case signOutFailed(message: String)
    case verificationEmailFailed(message: String)
    case userNotVerified
    case updatePasswordFailed(message: String)
    case passwordResetFailed(message: String)
    case reauthenticateFailed(message: String)
}

struct FirebaseAuthenticationServiceProvider: FirebaseAuthenticationService {
    func verifyPhoneNumber(phoneNumber: String, withCompletion completion: @escaping (Result<String, PhoneNumberVarificationError>) -> Void) {
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

    func signIn(withCredential credential: Credential, withCompletion completion: @escaping (Result<FirebaseUser, UserAuthenticationError>) -> Void) {
        Auth.auth().signIn(withEmail: credential.email, password: credential.password) { authResult, error in
            if error != nil {
                completion(.failure(UserAuthenticationError.loginFailed(message: error?.localizedDescription ?? "Login failed.")))
            }

            if let user = authResult?.user {
                let firebaseUser = FirebaseUser(id: user.uid, name: user.displayName ?? "Unknown User" , email: user.email ?? "Not a valid email", isAuthenticated: true, refreshToken: user.refreshToken ?? "", isVerified: user.isEmailVerified)

                completion(.success(firebaseUser))
            } else {
                completion(.failure(UserAuthenticationError.loginFailed(message: error?.localizedDescription ?? "Login failed.")))
            }
        }
    }

    func signUp(withCredentials credentials: Credential, withCompletion completion: @escaping (Result<FirebaseUser, UserAuthenticationError>) -> Void) {
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { authResult, error in
            if error != nil {
                completion(.failure(UserAuthenticationError.signUpFailed(message: error?.localizedDescription ?? "SignUp failed.")))
            }

            if let user = authResult?.user {
                let firebaseUser = FirebaseUser(id: user.uid, name: user.displayName ?? "Unknown User" , email: user.email ?? "Not a valid email", isAuthenticated: true, refreshToken: user.refreshToken ?? "", isVerified: user.isEmailVerified)
                completion(.success(firebaseUser))
            } else {
                completion(.failure(UserAuthenticationError.signUpFailed(message: error?.localizedDescription ?? "SignUp failed.")))
            }
        }
    }

    func signOut(withCompletion completion: @escaping (Result<String, UserAuthenticationError>) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion(.success("User logout"))
        } catch let signOutError as NSError {
            completion(.failure(UserAuthenticationError.signOutFailed(message: signOutError.localizedDescription)))
        }
    }

    func sendVerificationEmail(withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void) {
        Auth.auth().currentUser?.sendEmailVerification { (error) in
            if error != nil {
                completion(.failure(UserAuthenticationError.verificationEmailFailed(message: error?.localizedDescription ?? "Verification failed.")))
            } else {
                completion(.success(true))
            }
        }
    }

    func forgotPassword(forEmail email: String, withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                completion(.failure(UserAuthenticationError.passwordResetFailed(message: error?.localizedDescription ?? "Password reset failed.")))
            } else {
                completion(.success(true))
            }
        }
    }

    func updatePassword(withCredential credential: Credential, withCompletion completion: @escaping (Result<Bool, UserAuthenticationError>) -> Void) {
        Auth.auth().currentUser?.updatePassword(to: credential.password) { (error) in
            if error != nil {
                completion(.failure(UserAuthenticationError.updatePasswordFailed(message: error?.localizedDescription ?? "Password update failed.")))
            } else {
                completion(.success(true))
            }
        }
    }

    func reauthenticate(withCredential credential: Credential, withCompletion completion: @escaping (Result<FirebaseUser, UserAuthenticationError>) -> Void) {
        let user = Auth.auth().currentUser
        let authCredential = EmailAuthProvider.credential(withEmail: credential.email, password: credential.password)

        user?.reauthenticate(with: authCredential, completion: { (result, error) in
            if error != nil {
                completion(.failure(UserAuthenticationError.loginFailed(message: error?.localizedDescription ?? "Reauthenticated failed.")))
            }

            if let user = result?.user {
                let firebaseUser = FirebaseUser(id: user.uid, name: user.displayName ?? "Unknown User" , email: user.email ?? "Not a valid email", isAuthenticated: true, refreshToken: user.refreshToken ?? "", isVerified: user.isEmailVerified)

                completion(.success(firebaseUser))
            } else {
                completion(.failure(UserAuthenticationError.reauthenticateFailed(message: error?.localizedDescription ?? "Reauthenticated failed.")))
            }
        })
    }

    func getCurrentUser() -> FirebaseUser? {
        let firebaseAuthUser = Auth.auth().currentUser

        if let user = firebaseAuthUser {
            let currentUser = FirebaseUser(id: user.uid, name: user.displayName ?? "Unknown User" , email: user.email ?? "Not a valid email", isAuthenticated: true, refreshToken: user.refreshToken ?? "", isVerified: user.isEmailVerified)
            return currentUser
        } else {
            return nil
        }
    }

}
