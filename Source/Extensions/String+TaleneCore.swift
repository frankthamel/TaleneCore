//
//  String+TaleneCore.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/20/20.
//

import Foundation

extension String {
    func md5() -> String? {
        return md5Hash(str: self)
    }

    func sha256() -> String? {
        return sha_256(str: self)
    }
}
