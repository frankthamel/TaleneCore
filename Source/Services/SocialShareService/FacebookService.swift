//
//  FacebookService.swift
//  PPT
//
//  Created by Frank Emmanuel on 5/12/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKCoreKit

public protocol FacebookService: AppConfigure {
    func share(image: UIImage?, hashTag: String, inViewController controller: UIViewController, delegate: FacebookServiceDelegate?)
    func share(images: [UIImage?], hashTag: String, inViewController controller: UIViewController, delegate: FacebookServiceDelegate?)
    func share(urlString: String, withComment comment: String, hashTag: String, inViewController controller: UIViewController, delegate: FacebookServiceDelegate?)
    func share(comment: String, hashTag: String, inViewController controller: UIViewController, delegate: FacebookServiceDelegate?)
}

public protocol FacebookServiceDelegate: class {
    func didCompleteWithResults(results: [String : Any])
    func didFailWithError(error: Error)
    func didCancel()
}

class FacebookServiceProvider: NSObject, FacebookService {

    weak var delegate: FacebookServiceDelegate?

    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func share(image: UIImage?, hashTag: String, inViewController controller: UIViewController, delegate: FacebookServiceDelegate? = nil) {
        share(images: [image], hashTag: hashTag, inViewController: controller, delegate: delegate)
    }

    func share(images: [UIImage?], hashTag: String, inViewController controller: UIViewController, delegate: FacebookServiceDelegate? = nil) {
        if App.managers.connection.showReachableMesage() {
            return
        }

        self.delegate = delegate

        let photos = images.compactMap { $0 }.map {
            SharePhoto(image: $0, userGenerated: true)
        }

        let photoContent = SharePhotoContent()
        photoContent.photos = photos
        photoContent.hashtag = Hashtag(hashTag)

        let photoshareDialog = ShareDialog(fromViewController: controller, content: photoContent, delegate: self)
        if photoshareDialog.canShow {
            photoshareDialog.show()
        }
    }

    func share(urlString: String, withComment comment: String, hashTag: String, inViewController controller: UIViewController, delegate: FacebookServiceDelegate? = nil) {
        if App.managers.connection.showReachableMesage() {
            return
        }

        self.delegate = delegate

        guard let url = URL(string: urlString) else {
            return
        }

        let urlContent = ShareLinkContent()
        urlContent.contentURL = url
        urlContent.hashtag = Hashtag(hashTag)
        urlContent.quote = comment

        let urlshareDialog = ShareDialog(fromViewController: controller, content: urlContent, delegate: self)
        if urlshareDialog.canShow {
            urlshareDialog.show()
        }
    }

    func share(comment: String, hashTag: String, inViewController controller: UIViewController, delegate: FacebookServiceDelegate?) {
        let content = ShareLinkContent()
        content.hashtag = Hashtag(hashTag)
        content.quote = comment

        let urlshareDialog = ShareDialog(fromViewController: controller, content: content, delegate: self)
        if urlshareDialog.canShow {
            urlshareDialog.show()
        }
    }
}

extension FacebookServiceProvider: SharingDelegate {
    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        delegate?.didCompleteWithResults(results: results)
    }

    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        delegate?.didFailWithError(error: error)
    }

    func sharerDidCancel(_ sharer: Sharing) {
        delegate?.didCancel()
    }
}

