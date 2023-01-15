//
//  NameValidator.swift
//  Gridcap
//
//  Created by Yaroslav Babalich on 31.10.2021.
//

import Foundation

final class NameValidator: Validator {

    public var errorMessage: String?

    public func isValid(value: String?) -> Bool {

        guard value?.trimmed.nullable != nil else {
            errorMessage = "Validator.Error.EmptyName".localized
            return false
        }

        errorMessage = nil
        return true
    }
}
