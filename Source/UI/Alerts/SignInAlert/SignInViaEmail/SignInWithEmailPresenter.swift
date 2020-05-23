//
//  SignInWithEmailPresenter.swift
//  Alamofire
//
//  Created by Frank Emmanuel on 5/23/20.
//

import UIKit

protocol SiginInWithEmailView: class {

}

struct SignInWithEmailPresenter: AlertPresenterBase {
    weak var view: SiginInWithEmailView?
    var alertModel: AlertModel?

    init(with view: SiginInWithEmailView) {
        self.view = view
    }

    func setUp() {
        App.managers.analytics.track(event: SignInWithEmailEvents(.screenSetup))
    }
    
}
