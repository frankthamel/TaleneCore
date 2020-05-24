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
       presenter?.signIn(username: "w.frankthamel@gmail.com", password: "123456789")
       // presenter?.signIn(username: "frank@test.com", password: "123456")
        //presenter?.signUp(username: "annecharuka@gmail.com", password: "Abc@123456")
        //presenter?.signOut()
        //presenter?.passwordReset(username: "annecharuka@gmail.com")
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
