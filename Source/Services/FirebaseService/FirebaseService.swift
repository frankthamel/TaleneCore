//
//  FirebaseService.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/13/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation
import FirebaseCore

public protocol FirebaseService: AppConfigure {
    var firebaseAuthenticationService: FirebaseAuthenticationService { get set }
}

struct FirebaseServiceProvider: FirebaseService {
    var firebaseAuthenticationService: FirebaseAuthenticationService = FirebaseAuthenticationServiceProvider()

    func configure() {
        FirebaseApp.configure()
    }

}


