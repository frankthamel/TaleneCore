//
//  ZipService.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/2/20.
//

import Foundation
import SSZipArchive

public protocol Zip {
    func createZipFile(atPath path: String, withContentsOfDirectory contentDirectoryPath: String)
    func unzipFile(atPath path: String, toDestination destinationPath: String, withCompletion completion:((String, Bool, Error?) -> Void)?)
    func createZipFile(atPath path: String, withContentsOfDirectory contentDirectoryPath: String, password: String)
    func unzipFile(atPath path: String, toDestination destinationPath: String, password: String, withCompletion completion:((String, Bool, Error?) -> Void)?)
    func isFilePasswordProtected(_ filePath: String) -> Bool
}

struct ZipServiceProvider: Zip {
    func createZipFile(atPath path: String, withContentsOfDirectory contentDirectoryPath: String) {
        SSZipArchive.createZipFile(atPath: path, withContentsOfDirectory: contentDirectoryPath, keepParentDirectory: false, compressionLevel: -1, password: nil, aes: true, progressHandler: nil)
    }

    func unzipFile(atPath path: String, toDestination destinationPath: String, withCompletion completion:((String, Bool, Error?) -> Void)?) {
        SSZipArchive.unzipFile(atPath: path, toDestination: destinationPath, preserveAttributes: true, overwrite: true, nestedZipLevel: 1, password: nil, error: nil, delegate: nil, progressHandler: nil, completionHandler: completion)
    }

    func createZipFile(atPath path: String, withContentsOfDirectory contentDirectoryPath: String, password: String) {
        SSZipArchive.createZipFile(atPath: path, withContentsOfDirectory: contentDirectoryPath, keepParentDirectory: false, compressionLevel: -1, password: password, aes: true, progressHandler: nil)
    }

    func unzipFile(atPath path: String, toDestination destinationPath: String, password: String, withCompletion completion:((String, Bool, Error?) -> Void)?) {
        SSZipArchive.unzipFile(atPath: path, toDestination: destinationPath, preserveAttributes: true, overwrite: true, nestedZipLevel: 1, password: password, error: nil, delegate: nil, progressHandler: nil, completionHandler: completion)
    }

    func isFilePasswordProtected(_ filePath: String) -> Bool {
        return SSZipArchive.isFilePasswordProtected(atPath: filePath)
    }

}
