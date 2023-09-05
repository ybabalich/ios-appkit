//
//  PostfixOptionalOperator.swift
//  
//
//  Created by Yaroslav Babalich on 06.09.2023.
//

import Foundation

extension Optional {
    public func required() -> Wrapped {
        return self!
    }
}
