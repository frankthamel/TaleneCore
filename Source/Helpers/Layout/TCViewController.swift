//
//  TCViewController.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/31/20.
//

import UIKit

open class TCViewController: UIViewController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        App.context.activeViewController = self
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
