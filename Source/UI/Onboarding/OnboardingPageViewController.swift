//
//  OnboardingPageViewController.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 7/29/20.
//

import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var content : [OnboardingModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }


    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index: Int = (viewController as! OnboardingViewController).index
        index -= 1

        return contentViewController(at: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index: Int = (viewController as! OnboardingViewController).index
        index += 1
        return contentViewController(at: index)
    }

    func contentViewController(at index : Int) -> OnboardingViewController? {
        if index < 0 || index >= content.count {
            return nil
        }

        let storyboard = UIStoryboard(name: "Onboarding", bundle: App.store.mainBundle.getAppBundle())
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController {
            pageContentViewController.content = content
            pageContentViewController.index = index
            pageContentViewController.modalPresentationStyle = .fullScreen
            return pageContentViewController
        }

        return nil
    }

    func forward(index : Int) {
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }

}
