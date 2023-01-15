//
//  PasswordValidator.swift
//  Gridcap
//
//  Created by Yaroslav Babalich on 30.10.2021.
//

import Foundation

open class PasswordValidator: Validator {

    // MARK: - Public properties

    public var errorMessage: String?

    // MARK: - Initializers

    public init() { }

    // MARK: - Public methods

    public func isValidForLogin(value: String?) -> Bool {
        guard value?.trimmed.nullable != nil else {
            errorMessage = "Validator.Error.EmptyPassword".localized
            return false
        }

        errorMessage = nil
        return true
    }

    public func isValid(value: String?) -> Bool {

        guard let value = value?.trimmed.nullable else {
            errorMessage = "Validator.Error.EmptyPassword".localized
            return false
        }

        guard isValidPassword(value) else {
            errorMessage = "Validator.Error.InvalidPassword".localized
            return false
        }

        errorMessage = nil
        return true
    }
}
