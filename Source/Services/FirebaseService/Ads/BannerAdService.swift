//
//  FirebaseAdsService.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/5/20.
//

import UIKit
import GoogleMobileAds

public class FirebaseBannerAdsView: GADBannerView {}

public protocol BannerAdService: AppConfigure {
    func setUp(bannerAd : FirebaseBannerAdsView, rootViewController: UIViewController, delegate: FirebaseBannerAdsDelegate?)
    func loadBannerAd(bannerAd : FirebaseBannerAdsView)
}

public protocol FirebaseBannerAdsDelegate: class {
    func adViewDidReceiveAd()
    func didFailToReceiveAdWithError(error: Error)
    func adViewWillPresentScreen()
    func adViewWillDismissScreen()
    func adViewDidDismissScreen()
    func adViewWillLeaveApplication()
}

public extension FirebaseBannerAdsDelegate {
    func adViewDidReceiveAd() {}
    
    func didFailToReceiveAdWithError(error: Error) {}
    
    func adViewWillPresentScreen() {}
    
    func adViewWillDismissScreen() {}
    
    func adViewDidDismissScreen() {}
    
    func adViewWillLeaveApplication() {}
}

class BannerAdServiceProvider:NSObject, BannerAdService  {
    
    weak var delegate: FirebaseBannerAdsDelegate?
    
    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        
    }
    
    func setUp(bannerAd : FirebaseBannerAdsView, rootViewController: UIViewController, delegate: FirebaseBannerAdsDelegate?) {
        self.delegate = delegate
        bannerAd.adUnitID = App.settings.keys.bannerAdsID
        bannerAd.rootViewController = rootViewController
        bannerAd.delegate = self
    }
    
    func loadBannerAd(bannerAd : FirebaseBannerAdsView) {
        bannerAd.load(GADRequest())
    }
    
}

extension BannerAdServiceProvider: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        delegate?.adViewDidReceiveAd()
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        delegate?.didFailToReceiveAdWithError(error: error)
    }
    
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        delegate?.adViewWillPresentScreen()
    }
    
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        delegate?.adViewWillDismissScreen()
    }
    
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        delegate?.adViewDidDismissScreen()
    }
    
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        delegate?.adViewWillLeaveApplication()
    }
}

