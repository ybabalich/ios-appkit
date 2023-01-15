//
//  EmailValidator.swift
//  Gridcap
//
//  Created by Yaroslav Babalich on 30.10.2021.
//

import Foundation

open class EmailValidator: Validator {

    // MARK: - Public variables

    public var errorMessage: String?

    // MARK: - Initializers

    public init() { }

    // MARK: - Public methods

    public func isValid(value: String?) -> Bool {

        guard let value = value?.trimmed.nullable else {
            errorMessage = "Validator.Error.EmptyEmail".localized
            return false
        }

        guard isValidEmail(value) else {
            errorMessage = "Validator.Error.InvalidEmail".localized
            return false
        }

        errorMessage = nil
        return true
    }
}
