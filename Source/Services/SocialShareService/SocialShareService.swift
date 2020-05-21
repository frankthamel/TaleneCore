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
}

struct SocialShareServiceProvider: SocialShareService {

    var facebookService: FacebookService = FacebookServiceProvider()
    var twitterService: TwitterService = TwitterServiceProvider()

    func configure() {
        facebookService.configure()
        twitterService.configure()
    }
}
