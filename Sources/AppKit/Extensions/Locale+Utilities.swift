//
//  Locale+Utilities.swift
//  
//
//  Created by Yaroslav Babalich on 03.05.2021.
//

import Foundation

public extension Locale {

    func is24hFormatTime() -> Bool {
        let dateFormat = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current)
        if dateFormat?.range(of: "a") != nil {
            return false
        } else {
            return true
        }
    }
}
