//
//  CorneredView.swift
//  
//
//  Created by Yaroslav Babalich on 19.09.2021.
//

import UIKit

open class CorneredView: TappableView {

    // MARK: - Public properties

    public var corners: Corners = .default {
        didSet {
            layoutSubviews()
        }
    }

    // MARK: - Private properties

    private var oldFrame: CGRect = .zero

    // MARK: - Lifecycle

    public override func layoutSubviews() {
        super.layoutSubviews()

        if frame != oldFrame {

            switch corners {
            case .default: applyCorners(0)
            case .fullyRounded: applyCorners(bounds.height / 2)
            case .rounded(let radius): applyCorners(radius)
            }

            oldFrame = frame
        }
    }

}

public extension CorneredView {

    enum Corners {
        case `default`
        case fullyRounded
        case rounded(CGFloat)
    }
}
