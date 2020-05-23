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


