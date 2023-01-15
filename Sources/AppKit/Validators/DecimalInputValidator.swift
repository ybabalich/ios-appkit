//
//  DecimalInputValidator.swift
//  Gridcap
//
//  Created by Yaroslav Babalich on 30.10.2021.
//

import UIKit

open class DecimalInputValidator: NSObject, UITextFieldDelegate {

    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        isDecimal(string)
    }

    public func isDecimal(_ string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
