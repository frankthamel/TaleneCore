//
//  TCSignInWithEmailAlertView.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/21/20.
//

import UIKit
import Malert

class TCSignInWithEmailAlertView: UIView {

    var presenter: SignInPresenter?

    class func instantiateFromNib() -> TCSignInWithEmailAlertView {
        return App.store.mainBundle.getAppBundle().loadNibNamed("SignInWithEmailAlertView", owner: nil, options: nil)!.first as! TCSignInWithEmailAlertView
    }


}

extension TCSignInWithEmailAlertView: SignInView {

}

extension AppAlerts {
    func createSignInWithEmailAlert(model: AlertModel) -> Malert {
        let alertView = TCSignInWithEmailAlertView.instantiateFromNib()

        let presenter = SignInPresenter(with: alertView)
        presenter.alertModel = model
        alertView.presenter = presenter
        presenter.setUp()

        let alert = Malert(customView: alertView)
        return alert
    }
}
