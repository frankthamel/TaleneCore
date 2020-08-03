//
//  TCEncode+Decode.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/3/20.
//

import Foundation

public struct TCEncodeDecode {
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()

    public static func encode<T: Codable>(object: T) throws -> String? {
        if object is String { return object as? String }
        let data = try encoder.encode(object)
        let string = String(data: data, encoding: .utf8)
        return string
    }

    public static func decode<T: Codable>(string: String) throws -> T? {
        guard let data = string.data(using: .utf8) else { return nil }
        let object = try decoder.decode(T.self, from: data)
        return object
    }
}
