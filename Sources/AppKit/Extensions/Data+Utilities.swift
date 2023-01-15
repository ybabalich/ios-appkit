//
//  Data+Utilities.swift
//  
//
//  Created by Yaroslav Babalich on 10.04.2022.
//

import Foundation

extension Data {

    public var bool: Bool? {
        String(data: self, encoding: .utf8).flatMap(Bool.init)
    }
}
