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
    func getValue<T>(forKey key: String) -> T?
}

struct UserDefaultsStoreProvider: UserDefaultsStore {

    func save<T>(value: T, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    func getValue<T>(forKey key: String) -> T? {
        return UserDefaults.standard.object(forKey: key) as? T
    }

}
