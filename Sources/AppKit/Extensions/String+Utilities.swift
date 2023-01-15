//
//  String+Utilities.swift
//  
//
//  Created by Yaroslav Babalich on 30.11.2020.
//

import UIKit

public extension String {

    var withRemovedDashes: String {
        replacingOccurrences(of: "-", with: "")
    }

    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var nullable: String? {
        isEmpty ? nil : self
    }

    var removingContinuousWhitespaces: String {
        components(separatedBy: .whitespacesAndNewlines)
            .filter { $0.trimmed.nullable != nil }
            .joined(separator: " ")
    }

    var lastDotPath: String? {
        return components(separatedBy: ".").last
    }

    var capitalizedFirst: String {
        prefix(1).capitalized + dropFirst()
    }

    var forcedURL: URL {
        guard let retVal = URL(string: self) else {
            fatalError("Can't instantiate URL object from <\(self)>")
        }
        return retVal
    }

    func coverImage(titleColor: UIColor, fillColor: UIColor) -> UIImage? {

        let dimension = UIScreen.main.bounds.width
        let fontSize = round(dimension * 0.36)

        let coverSize = CGSize(width: dimension, height: dimension)

        UIGraphicsBeginImageContextWithOptions(coverSize, false, 0)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let font = UIFont.systemRoundedFont(ofSize: fontSize, weight: .bold)

        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle,
            .foregroundColor: titleColor
        ]

        //

        let canvasRect = CGRect(origin: .zero, size: coverSize)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(fillColor.cgColor)
        context?.fill(canvasRect)

        //

        let rect = CGRect(origin: CGPoint(x: 0, y: (coverSize.height - font.pointSize) / 2 - 8),
                          size: coverSize)

        (self as NSString).draw(in: rect, withAttributes: textAttributes)

        defer { UIGraphicsEndImageContext() }
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    func inLimit(of number: Int) -> Bool {
        let limitRange = 0...number
        return limitRange.contains(count)
    }

    func initials(maxInitialsCount: Int = 2) -> String {

        let allWords: [String] = self
            .removingContinuousWhitespaces
            .components(separatedBy: " ")

        guard allWords.count > 1 else { return prefix(maxInitialsCount).uppercased() }

        var retVal: String = ""

        for index in 0 ..< maxInitialsCount {
            guard index < allWords.count else { break }
            guard let firstCharacter = allWords[index].first else { break }

            retVal.append(firstCharacter)
        }

        return retVal.uppercased()
    }

    func generateShortIfNeeded(maxSymbols: Int) -> String {
        if self.count > maxSymbols {
            let finalString = "..."

            let substring = self[self.startIndex...self.index(self.startIndex, offsetBy: maxSymbols - finalString.count)] + finalString
            return String(substring)
        }

        return self
    }

    //
    // MARK: - Random Password Generator

    static var randomString: String {

        let uppercaseCharacters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let lowercaseCharacters = Array("abcdefghijklmnopqrstuvwxyz")
        let numberCharacters = Array("1234567890")
        let symbolCharacters = Array("._-+")

        var retVal = ""

        for _ in 0 ..< 5 {
            let index = Int(arc4random_uniform(UInt32(uppercaseCharacters.count)))
            retVal.append(uppercaseCharacters[index])
        }

        for _ in 0 ..< 15 {
            let index = Int(arc4random_uniform(UInt32(lowercaseCharacters.count)))
            retVal.append(lowercaseCharacters[index])
        }

        for _ in 0 ..< 5 {
            let index = Int(arc4random_uniform(UInt32(numberCharacters.count)))
            retVal.append(numberCharacters[index])
        }

        for _ in 0 ..< 5 {
            let index = Int(arc4random_uniform(UInt32(symbolCharacters.count)))
            retVal.append(symbolCharacters[index])
        }

        return retVal
    }

    //
    // MARK: - Texts

    static func randomText(length: Int) -> String {
        let characters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890._-+")

        var retVal = ""

        for _ in 0 ..< length {
            let index = Int(arc4random_uniform(UInt32(characters.count)))
            retVal.append(characters[index])
        }

        return retVal
    }

    func size(constrained toWidth: CGFloat, attributes: [NSAttributedString.Key: Any]) -> CGSize {
        self.boundingRect(
            with: CGSize(width: toWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin],
            attributes: attributes, context: nil
        ).integral.size
    }

    func setSuperscript(_ superscript: String, font: UIFont, color: UIColor, offset: CGFloat) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let foundRange = attributedString.mutableString.range(of: superscript)

        if foundRange.location != NSNotFound {
            attributedString.addAttribute(.font, value: font, range: foundRange)
            attributedString.addAttribute(.baselineOffset, value: offset, range: foundRange)
            attributedString.addAttribute(.foregroundColor, value: color, range: foundRange)
        }

        return attributedString
    }
}
