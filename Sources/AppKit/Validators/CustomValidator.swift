//
//  CustomValidator.swift
//  Gridcap
//
//  Created by Yaroslav Babalich on 16.11.2021.
//

import Foundation

open class CustomValidator {

    // MARK: - Initializers

    public init() { }

    // MARK: - Public methods

    public func isValid(value: String, pattern: String) -> Bool {
        guard validateString(value, pattern: pattern) else {
            return false
        }

        return true
    }

    // MARK: - Private methods

    private func validateString(_ value: String, pattern: String) -> Bool {
        guard value.range(of: pattern, options: .regularExpression, range: nil, locale: nil) != nil else {
            return false
        }

        return true
    }
}
