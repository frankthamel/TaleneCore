//
//  Database.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/6/20.
//

import Foundation
import RealmSwift

public typealias TCRealm = Realm
public typealias Db = Object
public typealias DbOptional = RealmOptional
public typealias DbList = List
public typealias DbResults = Results
public typealias DbRefreshToken = NotificationToken

public protocol Database: AppConfigure {
    func getRealm() -> TCRealm?
    func create<T: Db>(object: T?, realm: TCRealm?) -> Bool
    func object<T: Db>(forId id: String, realm: TCRealm?) -> T?
    func update(realm: TCRealm?, handler: () -> Void) -> Bool
    func delete<T: Db>(object: T?, realm: TCRealm?) -> Bool
    func clearAll(realm: TCRealm?) -> Bool
    func filter<T: Db>(query: String, realm: TCRealm?) -> DbResults<T>?
    func all<T: Db>(realm: TCRealm?) -> DbResults<T>?
}

class RealmDatabase: Database {

    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
    }

    func getRealm() -> TCRealm? {
        return try? TCRealm()
    }

    func create<T: Db>(object: T?, realm: TCRealm?) -> Bool {
        guard let obj = object else { return false }

        do {
            try realm?.write {
                realm?.add(obj)
            }
            return true
        } catch let error {
            print(error)
            return false
        }
    }

    func object<T: Db>(forId id: String, realm: TCRealm?) -> T? {
        let obj = realm?.object(ofType: T.self, forPrimaryKey: id)
        return obj
    }

    func update(realm: TCRealm?, handler: () -> Void) -> Bool {
        do {
            try realm?.write {
                handler()
            }
            return true
        } catch let error {
            print(error)
            return false
        }
    }

    func delete<T: Db>(object: T?, realm: TCRealm?) -> Bool {
        guard let obj = object else { return false }

        do {
            try realm?.write {
                realm?.delete(obj)
            }
            return true
        } catch let error {
            print(error)
            return false
        }
    }

    func clearAll(realm: TCRealm?) -> Bool {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
            return true
        } catch let error {
            print(error)
            return false
        }
    }

    func filter<T: Db>(query: String, realm: TCRealm?) -> DbResults<T>? {
        let results = realm?.objects(T.self).filter(query)

        if results?.count == 0 {
            return nil
        }

        return results
    }

    func all<T: Db>(realm: TCRealm?) -> DbResults<T>? {
        let results = realm?.objects(T.self)

        if results?.count == 0 {
            return nil
        }

        return results
    }


}


