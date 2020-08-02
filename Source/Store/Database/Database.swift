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
    func create<T: Db>(object: T?) -> Bool
    func createList<T: Db>(objects: [T]?) -> Bool
    func object<T: Db>(forId id: String) -> T?
    func update(handler: () -> Void) -> Bool
    func delete<T: Db>(object: T?) -> Bool
    func clearAll() -> Bool
    func filter<T: Db>(query: String) -> DbResults<T>?
    func all<T: Db>() -> DbResults<T>?
}

class RealmDatabase: Database {

    let realm = try? Realm()

    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
    }

    func getRealm() -> TCRealm? {
        return realm
    }

    func create<T: Db>(object: T?) -> Bool {
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

    func createList<T: Db>(objects: [T]?) -> Bool {
        guard let objs = objects else { return false }

        do {
            try realm?.write {
                for obj in objs {
                    realm?.add(obj)
                }
            }
            return true
        } catch let error {
            print(error)
            return false
        }
    }

    func object<T: Db>(forId id: String) -> T? {
        let obj = realm?.object(ofType: T.self, forPrimaryKey: id)
        return obj
    }

    func update(handler: () -> Void) -> Bool {
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

    func delete<T: Db>(object: T?) -> Bool {
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

    func clearAll() -> Bool {
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

    func filter<T: Db>(query: String) -> DbResults<T>? {
        let results = realm?.objects(T.self).filter(query)

        if results?.count == 0 {
            return nil
        }

        return results
    }

    func all<T: Db>() -> DbResults<T>? {
        let results = realm?.objects(T.self)

        if results?.count == 0 {
            return nil
        }

        return results
    }

}


