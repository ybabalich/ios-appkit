//
//  ManualAnimator.swift
//  
//
//  Created by Yaroslav Babalich on 08.07.2021.
//

import UIKit

public class ManualAnimator {

    public enum AnimationCurve {
        case linear, parametric, easeInOut, easeIn, easeOut

        func modify(_ toX: CGFloat) -> CGFloat {
            switch self {
            case .linear:
                return toX
            case .parametric:
                return toX.parametric
            case .easeInOut:
                return toX.quadraticEaseInOut
            case .easeIn:
                return toX.quadraticEaseIn
            case .easeOut:
                return toX.quadraticEaseOut
            }
        }
    }

    // MARK: - Initializers

    public init() { }

    // MARK: - Private properties

    private var displayLink: CADisplayLink?
    private var start = Date()
    private var total = TimeInterval(0)
    private var closure: ((CGFloat) -> Void)?
    private var animationCurve: AnimationCurve = .linear

    // MARK: - Public methods

    public func animate(duration: TimeInterval, curve: AnimationCurve = .linear, _ animations: @escaping (CGFloat) -> Void) {
        guard duration > 0 else { animations(1.0); return }
        reset()
        start = Date()
        closure = animations
        total = duration
        animationCurve = curve
        let displayLink = CADisplayLink(target: self, selector: #selector(tick))
        displayLink.add(to: .current, forMode: .common)
        self.displayLink = displayLink
    }

    public func reset() {
        displayLink?.invalidate()
        displayLink = nil
    }

    // MARK: - Private methods

    @objc
    private func tick() {
        let delta = Date().timeIntervalSince(start)
        var percentage = animationCurve.modify(CGFloat(delta) / CGFloat(total))
        if percentage < 0.0 { percentage = 0.0 } else if percentage >= 1.0 { percentage = 1.0; reset() }
        closure?(percentage)
    }
}

extension CGFloat {

    fileprivate var parametric: CGFloat {
        guard self > 0.0 else { return 0.0 }
        guard self < 1.0 else { return 1.0 }
        return ((self * self) / (2.0 * ((self * self) - self) + 1.0))
    }

    fileprivate var quadraticEaseInOut: CGFloat {
        guard self > 0.0 else { return 0.0 }
        guard self < 1.0 else { return 1.0 }
        if self < 0.5 { return 2 * self * self }
        return (-2 * self * self) + (4 * self) - 1
    }

    fileprivate var quadraticEaseOut: CGFloat {
        guard self > 0.0 else { return 0.0 }
        guard self < 1.0 else { return 1.0 }
        return -self * (self - 2)
    }

    fileprivate var quadraticEaseIn: CGFloat {
        guard self > 0.0 else { return 0.0 }
        guard self < 1.0 else { return 1.0 }
        return self * self
    }
}
