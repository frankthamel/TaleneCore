//
//  SignInAlertUIView.swift
//  PPT
//
//  Created by Frank Emmanuel on 4/12/20.
//  Copyright © 2020 TaleneSchool. All rights reserved.
//

import UIKit
import Malert

class SignInAlertUIView: UIView {

    var presenter: SignInPresenter?

    class func instantiateFromNib() -> SignInAlertUIView {
        return App.store.mainBundle.getAppBundle().loadNibNamed("SignInAlertUIView", owner: nil, options: nil)!.first as! SignInAlertUIView
    }

    // MARK: UI Elements

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var otpTextField: UITextField!

    @IBAction func didTapVerifyPhoneNumberButton(_ sender: Any) {
        presenter?.verifyPhoneNumber(number: phoneNumberTextField.text)
    }

    @IBAction func didTapSubmitOtpCode(_ sender: Any) {
        presenter?.signIn(code: otpTextField.text)
    }


}

extension SignInAlertUIView: SignInView {
//    func showAlertType(type: String) {
//        titleLabel.text = type
//    }
}

extension AppAlerts {
    public static func createSignInAlert(model: AlertModel) -> Malert {
        let alertView = SignInAlertUIView.instantiateFromNib()

        let presenter = SignInPresenter(with: alertView)
        presenter.alertModel = model
        alertView.presenter = presenter
        presenter.setUp()

        let alert = Malert(customView: alertView)
        return alert
    }
}
