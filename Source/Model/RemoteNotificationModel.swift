//
//  RemoteNotificationModel.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/31/20.
//

import Foundation

public struct RemoteNotificationModel {
    var title: String
    var body: String
    var hashTags: String?
    var openUrl: String?
    var shareUrl: String?
    var imageUrl: String?

    func toAdsShareModel() -> AdsShareModel {
        let hashTagList = hashTags?.split(separator: ",").map {
            "#\($0)"
        }
        let model = AdsShareModel(title:title ,message:body, hashTags: hashTagList ?? [], openUrl: openUrl, shareUrl: shareUrl, image: nil)
        return model
    }
}

