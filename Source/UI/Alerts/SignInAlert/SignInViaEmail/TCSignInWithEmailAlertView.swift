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
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: TCTextField!
    @IBOutlet weak var confirmPasswordStack: UIStackView!

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
        setUpConfirmPasswordTextField()
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

    private func setUpConfirmPasswordTextField() {
        confirmPasswordTextField.modifiedPlaceholder = TCSay.Authenticator.confirmPasswordPlaceHolder
        confirmPasswordTextField.validators = [.isEmptyValidator, .rangeValidator(above: 5, below: 20), .match(contain: passwordTextField.text ?? "")]
    }

    @IBAction func didTapForgotPasswordButton(_ sender: Any) {

        if emailTextField.isValid {
            App.managers.hapticFeedback.impact()
            presenter?.passwordReset(username: emailTextField.text)
        } else {
            App.managers.hapticFeedback.trigger(.error)
        }
    }

    @IBAction func didTapSignUpToggleButton(_ sender: Any) {
        App.managers.hapticFeedback.select()
        currentState = currentState == State.signIn ? State.signUp : State.signIn
    }

    @IBAction func didTapNextButton(_ sender: Any) {
        submit()
    }

    func submit() {
        switch currentState {
        case .signIn :
            if emailTextField.isValid && passwordTextField.isValid {
                App.managers.hapticFeedback.impact()
                nextAction?()
            } else {
                App.managers.hapticFeedback.trigger(.error)
            }
        case .signUp:
            if emailTextField.isValid && passwordTextField.isValid && confirmPasswordTextField.isValid {
                App.managers.hapticFeedback.impact()
                nextAction?()
            } else {
                App.managers.hapticFeedback.trigger(.error)
            }
        }
    }

    private func signInAction() {
        presenter?.signIn(username: emailTextField.text, password: passwordTextField.text)
    }

    private func signUpAction() {
        presenter?.signUp(username: emailTextField.text, password: passwordTextField.text)
    }

    private func setUpSignInPage() {
        nextAction = signInAction
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.forgotPasswordButton?.isHidden = false
            self?.confirmPasswordLabel.isHidden = true
            self?.confirmPasswordTextField.isHidden = true
            self?.confirmPasswordStack.isHidden = true
            self?.titleLabel.text = TCSay.Alerts.signIn
            self?.forgotPasswordHeightConstraint.constant = 20.0
            self?.layoutIfNeeded()
        }
    }

    private func setUpSignUpPage() {
        nextAction = signUpAction
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.forgotPasswordButton?.isHidden = true
            self?.confirmPasswordLabel.isHidden = false
            self?.confirmPasswordTextField.isHidden = false
            self?.confirmPasswordStack.isHidden = false
            self?.titleLabel.text = TCSay.Alerts.signUp
            self?.forgotPasswordHeightConstraint.constant = 0
            self?.layoutIfNeeded()
        }
    }

}

extension TCSignInWithEmailAlertView: SiginInWithEmailView {
    func setUpTheme() {
        nextButton.backgroundColor = App.settings.theme.primaryActionColor
        signUpToggleButton.backgroundColor = App.settings.theme.secondaryActionColor
        signUpToggleButton.setImage(UIImage(withFrameworkName: "toggle"), for: .normal)
        let signUpToggleButtonHeight = signUpToggleButton.frame.size.height
        let signUpToggleButtonWidth = signUpToggleButton.frame.size.width
        let imageEdgeInsets = UIEdgeInsets(top: (signUpToggleButtonHeight - 16.36)/2, left: (signUpToggleButtonWidth - 36)/2, bottom: (signUpToggleButtonHeight - 16.36)/2, right: (signUpToggleButtonWidth - 36)/2)
        signUpToggleButton.imageEdgeInsets = imageEdgeInsets
        signUpToggleButton.imageView?.contentMode = .scaleAspectFit
    }
}

extension TCSignInWithEmailAlertView: UITextFieldDelegate {

    func setUpTextFieldDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            return true
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            if currentState == .signIn {
                submit()
            }
            return true
        } else if textField == confirmPasswordTextField {
            textField.resignFirstResponder()
            if currentState == .signUp {
                submit()
            }
            return true
        }
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == confirmPasswordTextField {
            confirmPasswordTextField.validators = [.isEmptyValidator, .rangeValidator(above: 5, below: 20), .match(contain: passwordTextField.text ?? "")]
        }
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
