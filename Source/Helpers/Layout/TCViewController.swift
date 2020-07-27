//
//  TCViewController.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/31/20.
//

import UIKit

open class TCViewController: UIViewController {

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        App.context.activeViewController = self
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
