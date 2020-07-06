//
//  RemoteNotificationModel.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/31/20.
//

import Foundation

public struct RemoteNotificationModel {
    public var title: String
    public var body: String
    public var hashTags: String?
    public var openUrl: String?
    public var shareUrl: String?
    public var imageUrl: String?

    func toAdsShareModel() -> AdsShareModel {
        let hashTagList = hashTags?.split(separator: ",").map {
            "#\($0)"
        }
        let model = AdsShareModel(title:title ,message:body, hashTags: hashTagList ?? [], openUrl: openUrl, shareUrl: shareUrl, image: nil)
        return model
    }
}

