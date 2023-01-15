//
//  LastNameValidator.swift
//  
//
//  Created by Yaroslav Babalich on 22.06.2022.
//

import Foundation

open class LastNameValidator: Validator {

    // MARK: - Public properties

    public var errorMessage: String?

    // MARK: - Initializers

    public init() { }

    // MARK: - Public methods

    public func isValid(value: String?) -> Bool {

        guard let value = value?.trimmed.nullable else {
            errorMessage = "Validator.Error.EmptyLastName".localized
            return false
        }

        guard isValidLength(value, range: 3...30) else {
            errorMessage = "Validator.Error.InvalidLengthLastName".localized
            return false
        }

        errorMessage = nil
        return true
    }
}
