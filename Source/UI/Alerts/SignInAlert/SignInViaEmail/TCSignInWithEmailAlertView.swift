//
//  TCSignInWithEmailAlertView.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/21/20.
//

import UIKit
import Malert

class TCSignInWithEmailAlertView: UIView {

    var presenter: SignInWithEmailPresenter?

    override func awakeFromNib() {
        super.awakeFromNib()
        presenter?.setUp()
    }

    class func instantiateFromNib() -> TCSignInWithEmailAlertView {
        return App.store.mainBundle.getAppBundle().loadNibNamed("SignInWithEmailAlertView", owner: nil, options: nil)!.first as! TCSignInWithEmailAlertView
    }


    @IBAction func didTapSignInButton(_ sender: Any) {
        presenter?.signIn(username: "frank@test.com", password: "123456")
    }

    func didTapSignIn() {
        presenter?.signIn(username: "frank@test.com", password: "123456")
    }


}

extension TCSignInWithEmailAlertView: SiginInWithEmailView {

}

extension AppAlerts {
    public static func createSignInWithEmailAlert(model: AlertModel) -> Malert {
        let alertView = TCSignInWithEmailAlertView.instantiateFromNib()

        let presenter = SignInWithEmailPresenter(with: alertView)
        let malert = Malert(customView: alertView)

        model.malert = malert
        presenter.alertModel = model
        alertView.presenter = presenter
        presenter.setUp()

        return malert
    }
}
