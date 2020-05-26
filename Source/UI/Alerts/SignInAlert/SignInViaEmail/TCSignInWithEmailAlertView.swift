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
    @IBOutlet weak var forgotPasswordHeightConstraint: NSLayoutConstraint!

    var presenter: SignInWithEmailPresenter?
    var nextAction: (() -> Void)?

    var currentState: State = .signIn {
        didSet {
            switch currentState {
            case .signIn:
                setUpSignInPage()
            case .signUp:
                setUpSignUpPage()
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
        setUpTextFieldDelegates()
        setUpEmailTextField()
        setUpPasswordTextField()
        currentState = .signUp
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
            nextAction?()
        }
    }

    private func signInAction() {
        presenter?.signIn(username: emailTextField.text, password: passwordTextField.text)
    }

    private func signUpAction() {
        presenter?.signUp(username: emailTextField.text, password: passwordTextField.text)
    }

    private func setUpSignInPage() {
        signUpToggleButton.setTitle( "<<<", for: .normal)
        nextAction = signInAction
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.forgotPasswordButton?.isHidden = false
            self?.titleLabel.text = TCSay.Alerts.signIn
            self?.forgotPasswordHeightConstraint.constant = 20.0
            self?.layoutIfNeeded()
        }
    }

    private func setUpSignUpPage() {
        signUpToggleButton.setTitle( "<<<", for: .normal)
        nextAction = signUpAction
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.forgotPasswordButton?.isHidden = true
            self?.titleLabel.text = TCSay.Alerts.signUp
            self?.forgotPasswordHeightConstraint.constant = 0
            self?.layoutIfNeeded()
        }
    }

}

extension TCSignInWithEmailAlertView: SiginInWithEmailView {

}

extension TCSignInWithEmailAlertView: UITextFieldDelegate {

    func setUpTextFieldDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            return true
        } else if textField == passwordTextField {
            textField.resignFirstResponder()

            if emailTextField.isValid && passwordTextField.isValid {
                nextAction?()
            }

            return true
        }
        return true
    }

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
