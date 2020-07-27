//
//  AdsShareModel.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/31/20.
//

import Foundation

public struct AdsShareModel {
    public let title: String
    public let message: String
    public let hashTags: [String]
    public var openUrl: String?
    public var shareUrl: String?
    public var image: UIImage?
    public var useActivityViewController: Bool = true

    public init(title: String, message: String, hashTags: [String], openUrl: String? = nil, shareUrl: String? = nil, image: UIImage? = nil, useActivityViewController: Bool = true) {
        self.title = title
        self.message = message
        self.hashTags = hashTags
        self.openUrl = openUrl
        self.shareUrl = shareUrl
        self.image = image
        self.useActivityViewController = useActivityViewController
    }
}
