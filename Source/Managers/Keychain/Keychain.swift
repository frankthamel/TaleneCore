//
//  Keychain.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/2/20.
//

import Foundation

public protocol Keychain {
    func save<T: Codable>(data: T, forKey key: String, forUserAccount account: String)
    func getData<T: Codable>(forKey key: String, forUserAccount account: String) -> T?
    func clear(forUserAccount account: String)
}

struct KeychainManager: Keychain {
    func save<T>(data: T, forKey key: String, forUserAccount account: String) where T : Decodable, T : Encodable {
        App.services.keychain.save(data: data, forKey: key, forUserAccount: account)
    }

    func getData<T>(forKey key: String, forUserAccount account: String) -> T? where T : Decodable, T : Encodable {
        App.services.keychain.getData(forKey: key, forUserAccount: account)
    }

    func clear(forUserAccount account: String) {
        App.services.keychain.clear(forUserAccount: account)
    }
}
