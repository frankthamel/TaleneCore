//
//  SignInWithEmailPresenter.swift
//  Alamofire
//
//  Created by Frank Emmanuel on 5/23/20.
//

import UIKit

protocol SiginInWithEmailView: class {

}

class SignInWithEmailPresenter: AlertPresenterBase {
    weak var view: SiginInWithEmailView?
    var alertModel: AlertModel?

    init(with view: SiginInWithEmailView) {
        self.view = view
    }

    func setUp() {
        App.managers.analytics.track(event: SignInWithEmailEvents(.screenSetup))
    }

    func signIn(username: String?, password: String?) {
        App.managers.loader.show()
        guard let username = username, let password = password, let isFirebase = alertModel?.params?[TCConstants.isFirebase] as? Bool else {
            App.managers.loader.showFail()
            return
        }

        let credential = Credential(email: username, password: password, isFirebase: isFirebase)

        App.managers.authenticator.signIn(withCredential: credential) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success:
                App.managers.loader.showSuccess()
                self.alertModel?.malert?.dismiss(animated: true, completion: nil)
            case .failure:
                App.managers.loader.showFail()
            }
        }
    }

}
