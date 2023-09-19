//
//  UIImageView+Ratation360.swift
//  
//
//  Created by Yaroslav Babalich on 26.04.2021.
//

import UIKit

public extension UIImageView {

    fileprivate static let animationName: String = "rotationAnim360"

    func rotate360(duration: Double, repeatCount: Float = .infinity) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0.0
        animation.toValue = .pi * 2.0
        animation.duration = duration
        animation.repeatCount = repeatCount
        layer.add(animation, forKey: Self.animationName)
    }

    func stopAllAnimations() {
        layer.removeAllAnimations()
    }

    func pauseAnimation() {
        let time = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = time
    }

    func resumeAnimation() {
        let pauseTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0

        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pauseTime
        layer.beginTime = timeSincePause
    }
}
