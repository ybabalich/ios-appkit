//
//  View+Font.swift
//  
//
//  Created by Yaroslav Babalich on 28.09.2021.
//

import SwiftUI

public struct CustomFont: ViewModifier {

    public var size: CGFloat
    public var weight: Font.Weight

    public func body(content: Content) -> some View {
        content.font(Font.system(size: size,
                                 weight: weight,
                                 design: .default))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
public extension View {
    func fontMain(size: CGFloat, weight: Font.Weight) -> some View {
        return self.modifier(CustomFont(size: size, weight: weight))
    }
}
