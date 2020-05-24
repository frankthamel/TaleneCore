//
//  SignInModel.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/23/20.
//

import Foundation

public struct Credential: Codable {
    let email: String
    let password: String
    let isFirebase: Bool
}

public struct FirebaseUser: Codable {
    let id: String
    let name: String
    let email: String
    let isAuthenticated: Bool
    let refreshToken: String
    let isVerified: Bool

    func toUser() -> User {
        let user = User(id: id, name: name, email: email, isAuthenticated: isAuthenticated, refreshToken: refreshToken, isVerified: isVerified)
        return user
    }
}

public struct User: Codable {
    let id: String
    let name: String
    let email: String
    let isAuthenticated: Bool
    let refreshToken: String
    let isVerified: Bool
}


