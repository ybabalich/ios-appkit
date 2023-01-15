//
//  Validator.swift
//  Gridcap
//
//  Created by Yaroslav Babalich on 30.10.2021.
//

import Foundation

public protocol Validator {
    var errorMessage: String? { get }
    func isValid(value: String?) -> Bool
}

extension Validator {

    public func isValidLength(_ value: String, range: ClosedRange<Int>) -> Bool {
        return range.contains(value.count)
    }

    public func isValidEmail(_ value: String) -> Bool {
        let pattern = "^[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}$"
        return validateString(value, pattern: pattern)
    }

    public func isValidPassword(_ value: String) -> Bool {
        let pattern = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$"
        return validateString(value, pattern: pattern)
    }

    // minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character:
    public func isValidPasswordWithOneSymbol(_ value: String) -> Bool {
        let pattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        return validateString(value, pattern: pattern)
    }

    public func isAlphanumeric(_ value: String) -> Bool {
        let pattern = "^[A-Z0-9a-z._-]+$"
        return validateString(value, pattern: pattern)
    }

    public func isAlphanumericLowercased(_ value: String) -> Bool {
        let pattern = "^[0-9a-z_-]+$"
        return validateString(value, pattern: pattern)
    }

    public func containsAtLeastOneCapitalLetter(_ value: String) -> Bool {
        let pattern = "[A-Z]"
        return validateString(value, pattern: pattern)
    }

    public func containsAtLeastOneSymbol(_ value: String) -> Bool {
        let pattern = "[0-9._-]"
        return validateString(value, pattern: pattern)
    }

    //

    public func validateString(_ value: String, pattern: String) -> Bool {

        guard value.range(of: pattern, options: .regularExpression, range: nil, locale: nil) != nil else {
            return false
        }

        return true
    }
}
