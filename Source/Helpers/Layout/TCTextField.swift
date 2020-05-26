//
//  TCTextField.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/25/20.
//

import UIKit
import Foundation

class TCTextField: UITextField {

    let insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    var modifiedPlaceholder: String? {
        didSet {
            setPlaceholder()
        }
    }

    var isValid: Bool = false
    private var isEmptyValidator: ((String) -> Bool)?
    private var isEmailValidator: ((String) -> Bool)?
    private var rangeValidator: ((((String, Int, Int) -> Bool)), Int, Int)?

    var validators: [FormValidator] = [] {
        didSet {
            for validator in validators {
                switch validator {
                case .isEmptyValidator:
                    isEmptyValidator = FormValidators.isEmptyValidator
                case .emailValidator:
                    isEmailValidator = FormValidators.emailValidator
                case .rangeValidator(let above, let below):
                    rangeValidator = (FormValidators.rangeValidator, above, below)
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    func setUp() {
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        layer.borderColor = App.settings.theme.textFieldBorderColorLight.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 5
        layer.backgroundColor = App.settings.theme.textFieldBackgroundColorLight.cgColor
    }

    private func setPlaceholder() {
        if let ph = modifiedPlaceholder {
            let font = UIFont.systemFont(ofSize: 13)
            let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: App.settings.theme.textFieldPlaceholder]
            attributedPlaceholder = NSAttributedString(string: ph, attributes: attributes)
        }
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }


    @objc func textFieldDidChange() {

        var isEmpty = true
        var isValidEmail = true
        var isInValidRange = true

        if let isEmptyValidator = isEmptyValidator {
            isEmpty = isEmptyValidator(self.text ?? "")
            setErrorState(status: isEmpty)
        }

        if let isEmailValidator = isEmailValidator {
            isValidEmail = isEmailValidator(self.text ?? "")
            setErrorState(status: !isValidEmail)
        }

        if let rangeValidator = rangeValidator {
            isInValidRange = rangeValidator.0((self.text ?? ""), rangeValidator.1 , rangeValidator.2)
            setErrorState(status: !isInValidRange)
        }

        isValid = !isEmpty && isValidEmail && isInValidRange
    }

    func setErrorState(status: Bool) {
        if status {
            layer.borderColor = App.settings.theme.textFieldError.cgColor
        } else {
            layer.borderColor = App.settings.theme.textFieldBorderColorLight.cgColor
        }
    }

}
