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
                App.managers.loader.showSuccess()
                App.managers.logger.info(message: user)
                App.managers.notification.localNotificationManager.send(notification: TCConstants.appUser, info: ["user": user])
                App.store.userDefaults.save(value: true, forKey: TCConstants.userRegisterCompletedKey)
                self.alertModel?.malert?.dismiss(animated: true, completion: nil)
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

        let credential = Credential(email: username, password: password, isFirebase: isFirebase)

        App.managers.authenticator.signUp(withCredentials: credential) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let user):
                App.managers.logger.info(message: user)
                self.sendEmailVerification()
                App.managers.loader.showSuccess()
                App.managers.notification.localNotificationManager.send(notification: TCConstants.appUser, info: ["user": user])
                App.store.userDefaults.save(value: true, forKey: TCConstants.userRegisterCompletedKey)
                self.alertModel?.malert?.dismiss(animated: true, completion: nil)
            case .failure(let errorMessage):
                switch errorMessage {
                case .signUpFailed(let message):
                    App.managers.message.showMessage(model: MessageModel(title: "User SignUp Failed", subTitle: message, type: .error))
                default:
                    App.managers.message.showMessage(model: MessageModel(title: "User SignUp Failed", subTitle: TCSay.Authenticator.signUpfailed, type: .error))
                }
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
                    App.managers.logger.info(message: TCSay.Authenticator.emailVerificationMessage)
                    App.managers.message.showMessage(model: MessageModel(title: TCSay.Authenticator.emailVerification, subTitle: TCSay.Authenticator.emailVerificationMessage, type: .success, duration: .seconds(seconds: 4)))
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

        App.managers.authenticator.forgotPassword(forEmail: username) { result in
            switch result {
            case .success:
                App.managers.loader.showSuccess()
                App.managers.logger.info(message: TCSay.Authenticator.passwordResetMessege)
                App.managers.message.showMessage(model: MessageModel(title: TCSay.Authenticator.passwordReset, subTitle: TCSay.Authenticator.passwordResetMessege, type: .success, duration: .seconds(seconds: 4)))
            case .failure(let message):
                App.managers.logger.error(message: message)
                App.managers.loader.showFail()
            }
        }

    }

}
