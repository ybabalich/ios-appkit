//
//  TappableLabel.swift
//  
//
//  Created by Yaroslav Babalich on 21.01.2021.
//

import UIKit

public protocol TappableLabelDelegate: AnyObject {
    func tappableLabel(_ label: TappableLabel, didTapOn element: TappableLabel.Element)
}

open class TappableLabel: UILabel {

    public struct Element {
        public let text: String

        public func range(in string: String) -> NSRange {
            (string as NSString).range(of: text)
        }

        public init(text: String) {
            self.text = text
        }
    }

    // MARK: - Variables public

    public weak var delegate: TappableLabelDelegate?

    public var elements: [Element] = []

    // MARK: - Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    // MARK: - Private methods

    private func setup() {

        // general

        isUserInteractionEnabled = true

        // gestures

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLabel(gesture:))))
    }

    // MARK: - Events

    @objc
    private func tapLabel(gesture: UITapGestureRecognizer) {

        let labelString = attributedText?.string ?? text ?? ""

        elements.forEach { element in
            if gesture.didTapAttributedTextInLabel(label: self, inRange: element.range(in: labelString)) {
                delegate?.tappableLabel(self, didTapOn: element)
            }
        }
    }
}

extension TappableLabel.Element: Equatable {

    public static func == (lhs: TappableLabel.Element, rhs: TappableLabel.Element) -> Bool {
        lhs.text == rhs.text
    }
}
