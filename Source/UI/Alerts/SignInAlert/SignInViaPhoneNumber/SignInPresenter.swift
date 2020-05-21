//
//  SignInPresenter.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/12/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import UIKit

protocol SignInView: class {

}

class SignInPresenter: AlertPresenterBase  {

    weak var view: SignInView?
    var alertModel: AlertModel?

    init(with view: SignInView) {
        self.view = view
    }

    func setUp() {
        App.managers.analytics.track(event: SignInEvent(.screenSetup))
    }

    func verifyPhoneNumber(number: String?) {
        App.managers.loader.show()

        guard let number = number, !number.isEmpty else {
            App.managers.loader.showFail()
            return
        }

        App.managers.authenticator.verifyPhoneNumber(number: number, withCompletion: { result in
            switch result {
            case Result.success(let verificationID):
                App.managers.loader.showSuccess()
                print("verificationID \(verificationID)")
                /// Navigate to OTP enter screen
            case Result.failure:
                App.managers.loader.showFail()
            }
        })
    }

    func signIn(code: String?) {
        App.managers.loader.show()
        guard let code = code else {
            App.managers.loader.showFail()
            return
        }

        App.managers.authenticator.signIn(withVerificationCode: code, withCompletion: { result in
            switch result {
            case .success:
                App.managers.loader.showSuccess()
            case .failure:
                App.managers.loader.showFail()
            }
        })
    }

}
