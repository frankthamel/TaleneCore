//
//  TCSignInWithEmailAlertView.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/21/20.
//

import UIKit
import Malert

class TCSignInWithEmailAlertView: UIView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: TCTextField!
    @IBOutlet weak var passwordTextField: TCTextField!
    @IBOutlet weak var forgotPasswordButton: UIButton?
    @IBOutlet weak var signUpToggleButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    var presenter: SignInWithEmailPresenter?

    var currentState: State = .signIn {
        didSet {
            switch currentState {
            case .signIn:
                print("signIn")
            case .signUp:
                print("signUp")
            }
        }
    }

    enum State {
        case signIn
        case signUp
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        presenter?.setUp()
        setUpEmailTextField()
        setUpPasswordTextField()
    }

    class func instantiateFromNib() -> TCSignInWithEmailAlertView {
        return App.store.mainBundle.getAppBundle().loadNibNamed("SignInWithEmailAlertView", owner: nil, options: nil)!.first as! TCSignInWithEmailAlertView
    }

    private func setUpEmailTextField() {
        emailTextField.modifiedPlaceholder = TCSay.Authenticator.emailPlaceholder
        emailTextField.validators = [.isEmptyValidator, .emailValidator]
    }

    private func setUpPasswordTextField() {
        passwordTextField.modifiedPlaceholder = TCSay.Authenticator.passwordPlaceHolder
        passwordTextField.validators = [.isEmptyValidator, .rangeValidator(above: 5, below: 20)]
    }

    @IBAction func didTapSignInButton(_ sender: Any) {
       presenter?.signIn(username: "w.frankthamel@gmail.com", password: "123456789")
        //presenter?.signIn(username: "frank@test.com", password: "123456")
        //presenter?.signUp(username: "annecharuka@gmail.com", password: "Abc@123456")
        //presenter?.signOut()
        //presenter?.passwordReset(username: "annecharuka@gmail.com")
    }

    @IBAction func didTapForgotPasswordButton(_ sender: Any) {
        if emailTextField.isValid {
            presenter?.passwordReset(username: emailTextField.text)
        }
    }

    @IBAction func didTapSignUpToggleButton(_ sender: Any) {
        currentState = currentState == State.signIn ? State.signUp : State.signIn
    }

    @IBAction func didTapNextButton(_ sender: Any) {
        if emailTextField.isValid && passwordTextField.isValid {
            presenter?.signIn(username: emailTextField.text, password: passwordTextField.text)
        }
    }

}

extension TCSignInWithEmailAlertView: SiginInWithEmailView {

}

extension AppAlerts {
    public static func createSignInWithEmailAlert(model: AlertModel) -> Malert {
        let alertView = TCSignInWithEmailAlertView.instantiateFromNib()

        let presenter = SignInWithEmailPresenter(with: alertView)
        let malert = Malert(customView: alertView)
        malert.separetorColor = .clear
        malert.backgroundColor = .clear
        malert.cornerRadius = 20

        model.malert = malert
        presenter.alertModel = model
        alertView.presenter = presenter
        presenter.setUp()

        return malert
    }
}
