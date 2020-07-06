//
//  SignInModel.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/23/20.
//

import Foundation

public struct Credential: Codable {
    public let email: String
    public let password: String
    public let isFirebase: Bool
}

public struct FirebaseUser: Codable {
    public let id: String
    public let name: String
    public let email: String
    public let isAuthenticated: Bool
    public let refreshToken: String
    public let isVerified: Bool

    public func toUser() -> User {
        let user = User(id: id, name: name, email: email, isAuthenticated: isAuthenticated, refreshToken: refreshToken, isVerified: isVerified)
        return user
    }
}

public struct User: Codable {
    public let id: String
    public let name: String
    public let email: String
    public let isAuthenticated: Bool
    public let refreshToken: String
    public let isVerified: Bool
}


