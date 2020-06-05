//
//  VideoAdService.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/5/20.
//

import UIKit
import GoogleMobileAds

public protocol VideoAdService: AppConfigure {
    func loadVideoAd()
    func presentVideoAd(fromRootViewController controller: UIViewController, delegate: FirebaseVideoAdsDelegate?)
}

public protocol FirebaseVideoAdsDelegate: class {
    func userDidEarnReward(reward: Int)
    func rewardedAdDidPresent()
    func rewardedAdDidDismiss()
    func didFailToPresentWithError(error: Error)
}

public extension FirebaseVideoAdsDelegate {
    func userDidEarnReward(reward: Int) {}
    func rewardedAdDidPresent() {}
    func rewardedAdDidDismiss() {}
    func didFailToPresentWithError(error: Error) {}
}

class VideoAdServiceProvider:NSObject, VideoAdService {
    weak var delegate: FirebaseVideoAdsDelegate?
    var rewardedAd: GADRewardedAd?

    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        rewardedAd = GADRewardedAd(adUnitID: App.settings.keys.videoAdsID ?? "")
    }

    func loadVideoAd() {
        rewardedAd?.load(GADRequest()) { error in
            if let error = error {
                App.managers.logger.error(message: error.localizedDescription)
            } else {
                App.managers.logger.info(message: "Video Ad successfully loaded.")
            }
        }
    }

    func presentVideoAd(fromRootViewController controller: UIViewController, delegate: FirebaseVideoAdsDelegate?) {
        self.delegate = delegate
        if rewardedAd?.isReady == true {
            rewardedAd?.present(fromRootViewController: controller, delegate: self)
        }
    }
}

extension VideoAdServiceProvider: GADRewardedAdDelegate {
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        delegate?.userDidEarnReward(reward: Int(truncating: reward.amount))
    }

    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
        delegate?.rewardedAdDidPresent()
    }

    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        delegate?.rewardedAdDidDismiss()
        TCRun.onBackgroundThread { [weak self] in
            self?.rewardedAd = nil
            self?.rewardedAd = GADRewardedAd(adUnitID: App.settings.keys.videoAdsID ?? "")
            self?.loadVideoAd()
        }
    }

    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        delegate?.didFailToPresentWithError(error: error)
    }
}
