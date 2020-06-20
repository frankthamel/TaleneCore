//
//  FirebaseCloudFireStoreService.swift
//  TaleneCore
//
//  Created by Emmanuvel Thamel on 6/17/20.
//

import Foundation
import FirebaseFirestore

public protocol FirebaseCloudFireStoreService: AppConfigure {

}

class FirebaseCloudFireStoreServiceProvider: FirebaseCloudFireStoreService  {

    var db: Firestore? = nil

    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        db = Firestore.firestore()
    }

    

}
