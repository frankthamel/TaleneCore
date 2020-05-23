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


}

extension TCSignInWithEmailAlertView: SiginInWithEmailView {

}

extension AppAlerts {
    public static func createSignInWithEmailAlert(model: AlertModel) -> Malert {
        let alertView = TCSignInWithEmailAlertView.instantiateFromNib()

        var presenter = SignInWithEmailPresenter(with: alertView)
        presenter.alertModel = model
        alertView.presenter = presenter
        presenter.setUp()

        let alert = Malert(customView: alertView)
        return alert
    }
}
