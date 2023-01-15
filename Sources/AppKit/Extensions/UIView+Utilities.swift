//
//  UIView+Utilities.swift
//  Sparta
//
//  Created by Yaroslav Babalich on 27.11.2020.
//

import UIKit

public extension UIView {

    // MARK: - Class methods

    class func nib<T: UIView>() -> T {
        var className = NSStringFromClass(self)
        className = className.split { $0 == "." }.map(String.init)[1]
        return Bundle.main.loadNibNamed(className, owner: nil, options: nil)![0] as! T //swiftlint:disable:this force_cast
    }

    // MARK: - Public methods

    func rotate(degrees: CGFloat) {
        let degreesToRadians: (CGFloat) -> CGFloat = { (degrees: CGFloat) in
            return degrees / 180.0 * CGFloat.pi
        }

        transform = CGAffineTransform(rotationAngle: degreesToRadians(degrees))
    }

    func applyCorners(_ radius: CGFloat) {
        applyCorners(radius, topLeft: true, topRight: true, bottomRight: true, bottomLeft: true)
    }

    func applyCorners(_ radius: CGFloat, topLeft: Bool, topRight: Bool, bottomRight: Bool, bottomLeft: Bool) {

        var corners = UIRectCorner()
        var maskedCorners = CACornerMask()

        if topLeft {
            corners = corners.union(.topLeft)
            maskedCorners = maskedCorners.union(.layerMinXMinYCorner)
        }

        if topRight {
            corners = corners.union(.topRight)
            maskedCorners = maskedCorners.union(.layerMaxXMinYCorner)
        }

        if bottomRight {
            corners = corners.union(.bottomRight)
            maskedCorners = maskedCorners.union(.layerMaxXMaxYCorner)
        }

        if bottomLeft {
            corners = corners.union(.bottomLeft)
            maskedCorners = maskedCorners.union(.layerMinXMaxYCorner)
        }

        if #available(iOS 11.0, *) {
            layer.cornerRadius = radius
            layer.maskedCorners = maskedCorners
        } else {
            let maskPath = UIBezierPath(roundedRect: self.bounds,
                                        byRoundingCorners: corners,
                                        cornerRadii: CGSize(width: radius, height: radius))
            let layer1 = CAShapeLayer()
            layer1.path = maskPath.cgPath
            self.layer.mask = layer1
        }
    }

    func removeAllSubviews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }

    func allSubviewsOf<T: UIView>(type: T.Type) -> [T] {
        var all = [T]()

        func getSubview(view: UIView) {
            if let aView = view as? T {
                all.append(aView)
            }

            guard !view.subviews.isEmpty else { return }

            view.subviews.forEach {
                getSubview(view: $0)
            }
        }

        getSubview(view: self)
        return all
    }

    var selectedField: UITextField? {

        let totalTextFields = allFields(in: self)

        for textField in totalTextFields where textField.isFirstResponder {
            return textField
        }

        return nil
    }

    func allFields(in view: UIView) -> [UITextField] {

        var totalTextFields = [UITextField]()

        for subview in view.subviews as [UIView] {
            if let textField = subview as? UITextField {
                totalTextFields += [textField]
            } else {
                totalTextFields += allFields(in: subview)
            }
        }

        return totalTextFields
    }
}
