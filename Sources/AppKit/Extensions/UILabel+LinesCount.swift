//
//  UILabel+LinesCount.swift
//  
//
//  Created by Yaroslav Babalich on 20.11.2022.
//

import UIKit

extension UILabel {
    public func calculateMaxLines(for width: CGFloat) -> Int {
        let maxSize = CGSize(width: width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}
