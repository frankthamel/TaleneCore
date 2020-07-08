//
//  KeychainService.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/2/20.
//

import Foundation
import Locksmith

public protocol KeychainService {
    func save<T: Codable>(data: T, forKey key: String, forUserAccount account: String)
    func getData<T: Codable>(forKey key: String, forUserAccount account: String) -> T?
    func clear(forUserAccount account: String)
}

struct KeychainServiceProvider: KeychainService {

    func save<T>(data: T, forKey key: String, forUserAccount account: String) where T : Decodable, T : Encodable {
        guard let encodedData = try? TCEncodeDecode.encode(object: data) else { return }
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: account)

        if let dict = dictionary, dict.keys.contains(key) {
            do {
                try Locksmith.updateData(data: [key: encodedData], forUserAccount: account)
            } catch let error {
                App.managers.logger.error(message: "Faild to update keychain. \(error.localizedDescription)")
            }
        } else {
            do {
                try Locksmith.saveData(data: [key: encodedData], forUserAccount: account)
            } catch let error {
                App.managers.logger.error(message: "Faild to save data to keychain. \(error.localizedDescription)")
            }
        }
    }

    func getData<T>(forKey key: String, forUserAccount account: String) -> T? where T : Decodable, T : Encodable {
        guard let dictionary = Locksmith.loadDataForUserAccount(userAccount: account) else { return nil }
        guard let encodedData = dictionary[key] as? String else { return nil }
        guard let decodedData: T = try? TCEncodeDecode.decode(string: encodedData) else { return nil }
        return decodedData
    }

    func clear(forUserAccount account: String) {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: account)
        } catch let error {
            App.managers.logger.error(message: "Faild to clear keychain. \(error.localizedDescription)")
        }
    }
    
}
