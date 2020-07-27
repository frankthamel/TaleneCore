//
//  SocialShareService.swift
//  PPT
//
//  Created by Frank Emmanuel on 5/12/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import Foundation

public protocol SocialShareService: AppConfigure {
    var facebookService: FacebookService { get set }
    var twitterService: TwitterService { get set }
    var activityViewController: ActivityViewControllerService { get set }
}

struct SocialShareServiceProvider: SocialShareService {

    var facebookService: FacebookService = FacebookServiceProvider()
    var twitterService: TwitterService = TwitterServiceProvider()
    var activityViewController: ActivityViewControllerService = ActivityViewControllerServiceProvider()

    func configure<T>(inType type: T, application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        facebookService.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)
        twitterService.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)
        activityViewController.configure(inType: type, application: application, didFinishLaunchingWithOptions: launchOptions)
    }
}
