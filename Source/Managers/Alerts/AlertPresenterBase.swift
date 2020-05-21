//
//  AlertPresenterBase.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/13/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

protocol AlertPresenterBase {
    var alertModel: AlertModel? { get set }
    func setUp()
}
