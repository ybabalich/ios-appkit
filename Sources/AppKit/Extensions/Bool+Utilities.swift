//
//  Bool+Utilities.swift
//  
//
//  Created by Yaroslav Babalich on 10.04.2022.
//

import Foundation

extension Bool {

    public var data: Data {
        Data(String(self).utf8)
    }
}
