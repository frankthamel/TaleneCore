//
//  ActivityViewControllerService.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 7/27/20.
//

import Foundation

public protocol ActivityViewControllerService: AppConfigure {
    func share(_ model: AdsShareModel, inController viewController: UIViewController, withCompletion completion: ((Bool) -> Void)? )
}

class ActivityViewControllerServiceProvider: NSObject, ActivityViewControllerService {
    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {

    }

    func share(_ model: AdsShareModel, inController viewController: UIViewController, withCompletion completion: ((Bool) -> Void)? ) {
        let items: [Any] = [model.message, model.hashTags.first ?? App.settings.configs.lc.hashTag, URL(string: model.shareUrl ?? App.settings.configs.lc.websiteUrl.absoluteString) ?? App.settings.configs.lc.websiteUrl ]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        viewController.present(ac, animated: true) {
            completion?(true)
        }
    }

}
