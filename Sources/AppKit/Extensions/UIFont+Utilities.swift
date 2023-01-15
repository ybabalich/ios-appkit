//
//  UIFont+Sparta.swift
//  Sparta
//
//  Created by Yaroslav Babalich on 29.11.2020.
//

import UIKit

public extension UIFont {

    static func main(weight: UIFont.Weight, size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight) // swiftlint:disable:this force_unwrapping
    }

    static func systemRoundedFont(ofSize size: CGFloat, weight: Weight) -> UIFont {

        // Will be SF Compact or standard SF in case of failure.
        let defaultFont = systemFont(ofSize: size, weight: weight)

        guard #available(iOS 13, *) else { return defaultFont }
        guard let descriptor = defaultFont.fontDescriptor.withDesign(.rounded) else { return defaultFont }

        return UIFont(descriptor: descriptor, size: size)
    }
}

public extension UIFont.Weight {

    static var lightItalic: UIFont.Weight {
        return UIFont.Weight(rawValue: -1)
    }
}
