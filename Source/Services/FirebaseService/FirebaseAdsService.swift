//
//  FirebaseAdsService.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/5/20.
//

import UIKit
import GoogleMobileAds

public protocol FirebaseAdsService: AppConfigure {
    var bannerAdsService: BannerAdService { get set }
    var videoAdsService: VideoAdService { get set }
}

class FirebaseAdsServiceProvider: FirebaseAdsService  {
    
    var bannerAdsService: BannerAdService = BannerAdServiceProvider()
    var videoAdsService: VideoAdService = VideoAdServiceProvider()
    
    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        bannerAdsService.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)
        videoAdsService.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)
    }
    
}
