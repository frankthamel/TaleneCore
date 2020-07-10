//
//  Membership.swift
//  TaleneCore_Example
//
//  Created by Emmanuvel Thamel on 7/10/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

struct Membership: Codable {
    let id: String
    let type: MembershipType
}

enum MembershipType: Int, Codable {
    case pro = 1
    case unknown = 2
    case registered = 3
}
