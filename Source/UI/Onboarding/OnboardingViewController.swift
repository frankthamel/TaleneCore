//
//  OnboardingViewController.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 7/29/20.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButtonX!

    var index: Int = 0
    var content: [OnboardingModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animate()
    }

    @IBAction func didTapOnNextButton(_ sender: Any) {
        switch index {
        case 0..<content.count - 1:
            let pageViewController = parent as! OnboardingPageViewController
            pageViewController.forward(index: index)
        default:
            dismiss(animated: true, completion: nil)
        }
    }

    func configureUI() {
        switch index {
        case 0..<content.count - 1:
            nextButton.setTitle("NEXT", for: .normal)
        default:
            nextButton.setTitle("DONE", for: .normal)
        }

        let model = content[index]
        imageView.image = model.informationImage

        titleLabel.text = model.title
        titleLabel.font = model.titleFont
        titleLabel.textColor = model.titleColor

        descriptionLabel.text = model.description
        descriptionLabel.font = model.descriptionFont
        descriptionLabel.textColor = model.descriptionColor

        pageControl.numberOfPages = content.count
        pageControl.currentPage = index

    }

    func animate() {

        imageView.transform = CGAffineTransform(translationX: -100, y: 0)
        UIView.animate(withDuration: 0.6) {
            self.imageView.transform = CGAffineTransform.identity
        }
      
        titleLabel.transform = CGAffineTransform(translationX: -100, y: 0)
        UIView.animate(withDuration: 0.8) {
            self.titleLabel.transform = CGAffineTransform.identity
        }

        descriptionLabel.transform = CGAffineTransform(translationX: -100, y: 0)
        UIView.animate(withDuration: 1) {
            self.descriptionLabel.transform = CGAffineTransform.identity
        }
    }

}
