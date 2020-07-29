//
//  OnboardingManager.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 7/28/20.
//

import UIKit

public protocol Onboarding {
    func show(info: [OnboardingModel], inViewController viewController: UIViewController)
}

class OnboardingManager: Onboarding {
    func show(info: [OnboardingModel], inViewController viewController: UIViewController) {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: App.store.mainBundle.getAppBundle())
        if let pageviewcontroller = storyboard.instantiateViewController(withIdentifier: "OnboardingPageViewController") as? OnboardingPageViewController {
            pageviewcontroller.modalPresentationStyle = .fullScreen
            pageviewcontroller.content = info
            viewController.present(pageviewcontroller, animated: true, completion: nil)
        }
    }
}
