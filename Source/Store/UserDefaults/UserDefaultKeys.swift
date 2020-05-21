//
//  UserDefaultKeys.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/14/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

enum UserDefaultKeys: String {

    func key() -> String {
        return self.rawValue
    }

    //MARK: Firebase Authentication
    case verificationID
    case userMobileNumber


}

