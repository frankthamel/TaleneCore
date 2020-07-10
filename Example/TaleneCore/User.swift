//
//  User.swift
//  TaleneCore_Example
//
//  Created by Frank Emmanuel on 6/6/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import TaleneCore

class User: Db {
    @objc dynamic var id = getRandomID()
    @objc dynamic var username = ""
    @objc dynamic var email = ""
    @objc dynamic var mobile: String? = nil

    override static func primaryKey() -> String? {
        return "id"
    }

    override static func indexedProperties() -> [String] {
        return ["username"]
    }

}

extension User {

    static func object(forId id: String) -> User? {
        return App.store.db.object(forId: id)
    }

    static func filterBy(username: String) -> DbResults<User>? {
        return App.store.db.filter(query: "username == '\(username)'")
    }

    static func all() -> DbResults<User>? {
        return App.store.db.all()
    }
}


