//
//  UserDefaultsStore.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/14/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

public protocol UserDefaultsStore {
    func save<T>(value: T, forKey key: String)
    func saveObject<T: Codable>(value: T, forKey key: String) -> Bool
    func getValue<T>(forKey key: String) -> T?
    func getObject<T: Codable>(forKey key: String) -> T?
}

struct UserDefaultsStoreProvider: UserDefaultsStore {

    func save<T>(value: T, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    func saveObject<T: Codable>(value: T, forKey key: String) -> Bool {
        let encodedData = try? TCEncodeDecode.encode(object: value)
        guard let data = encodedData else {
            return false
        }

        UserDefaults.standard.set(data, forKey: key)
        return true
    }

    func getValue<T>(forKey key: String) -> T? {
        return UserDefaults.standard.object(forKey: key) as? T
    }

    func getObject<T: Codable>(forKey key: String) -> T? {
        let dataString: String? = getValue(forKey: key)
        guard let data = dataString  else {
            return nil
        }
        
        let object: T? = try? TCEncodeDecode.decode(string: data)
        return object
    }

}
