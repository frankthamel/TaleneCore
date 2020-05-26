//
//  SignInWithEmailPresenter.swift
//  Alamofire
//
//  Created by Frank Emmanuel on 5/23/20.
//

import UIKit

protocol SiginInWithEmailView: class {
    func setUpTheme()
}

class SignInWithEmailPresenter: AlertPresenterBase {
    weak var view: SiginInWithEmailView?
    var alertModel: AlertModel?

    init(with view: SiginInWithEmailView) {
        self.view = view
    }

    func setUp() {
        App.managers.analytics.track(event: SignInWithEmailEvents(.screenSetup))
        view?.setUpTheme()
    }

    func signIn(username: String?, password: String?) {
        App.managers.loader.show()
        guard let username = username, let password = password, let isFirebase = alertModel?.params?[TCConstants.isFirebase] as? Bool else {
            App.managers.loader.showFail()
            return
        }

        // validate form fields

        let credential = Credential(email: username, password: password, isFirebase: isFirebase)

        App.managers.authenticator.signIn(withCredential: credential) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let user):
                if user.isVerified {
                    App.managers.loader.showSuccess()
                    App.managers.logger.info(message: user)
                    self.alertModel?.malert?.dismiss(animated: true, completion: nil)
                } else {
                    //TODO: Verify Email info message
                    App.managers.loader.showFail()
                    App.managers.logger.error(message: "Email not verified.")
                    App.managers.authenticator.signOut { signOutResult in
                        switch signOutResult {
                        case .success(let message):
                            App.managers.logger.info(message: message)
                        case .failure(let errorMessage):
                            App.managers.logger.error(message: errorMessage)
                        }
                    }
                }
            case .failure(let errorMessage):
                App.managers.logger.error(message: errorMessage)
                App.managers.loader.showFail()
            }
        }
    }

    func signUp(username: String?, password: String?) {
        App.managers.loader.show()
        guard let username = username, let password = password, let isFirebase = alertModel?.params?[TCConstants.isFirebase] as? Bool else {
            App.managers.loader.showFail()
            return
        }

        // validate form fields

        let credential = Credential(email: username, password: password, isFirebase: isFirebase)

        App.managers.authenticator.signUp(withCredentials: credential) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let user):
                App.managers.logger.info(message: user)
                self.sendEmailVerification()
                App.managers.loader.showSuccess()
                self.alertModel?.malert?.dismiss(animated: true, completion: nil)
            case .failure(let errorMessage):
                App.managers.logger.error(message: errorMessage)
                App.managers.loader.showFail()
            }
        }
    }

    func signOut() {
        App.managers.loader.show()
        App.managers.authenticator.signOut { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let message):
                App.managers.loader.showSuccess()
                App.managers.logger.info(message: message)
                self.alertModel?.malert?.dismiss(animated: true, completion: nil)
            case .failure(let errorMessage):
                App.managers.logger.error(message: errorMessage)
                App.managers.loader.showFail()
            }
        }
    }

    func sendEmailVerification() {
        App.managers.loader.show()
        App.managers.authenticator.sendVerificationEmail { result in
            switch result {
            case .success(let status):
                if status {
                    App.managers.loader.showSuccess()
                    App.managers.logger.info(message: "Email verification sent successfully.")
                }
            case .failure(let message):
                App.managers.logger.error(message: message)
                App.managers.loader.showFail()
            }
        }
    }

    func passwordReset(username: String?) {
        App.managers.loader.show()

        guard let username = username else {
            App.managers.loader.showFail()
            return
        }

        // validate username as email

        App.managers.authenticator.forgotPassword(forEmail: username) { result in
            switch result {
            case .success:
                App.managers.loader.showSuccess()
                App.managers.logger.info(message: "Password reset sent successfully.")
            case .failure(let message):
                App.managers.logger.error(message: message)
                App.managers.loader.showFail()
            }
        }

    }

}
