//
//  FormValidators.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/25/20.
//

import Foundation

enum FormValidator {
    case isEmptyValidator
    case emailValidator
    case rangeValidator(above: Int, below: Int)
    case match(contain: String)
}

public struct FormValidators {

    public static func isEmptyValidator(input: String) -> Bool {
        return input.isEmpty
    }

    public static func emailValidator(input: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: input)
    }

    public static func rangeValidator(input: String, above: Int, below: Int) -> Bool {
        return (above < input.count) && (input.count < below)
    }

    public static func matchValidator(base: String, matchTo match: String) -> Bool {
        return base == match
    }

}


