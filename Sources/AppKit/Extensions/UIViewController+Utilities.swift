//
//  UIViewController+Utilities.swift
//  Sparta
//
//  Created by Yaroslav Babalich on 27.11.2020.
//

import UIKit
import SnapKit

public extension UIViewController {

    var topBarHeight: CGFloat {
        navigationController?.navigationBar.wholeHeight ?? 0.0
    }

    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }

    static var topController: UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }

    static func topMostViewController(base: UIViewController?) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return topMostViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topMostViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return topMostViewController(base: presented)
        }

        return base
    }

    func applyClearStyle() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}

// MARK: - Childs

public extension UIViewController {

    func add(_ child: UIViewController, to view: UIView? = nil) {
        addChild(child)

        if let view = view {
            view.addSubview(child.view) {
                $0.edges.equalToSuperview()
            }
        } else {
            addSubview(child.view) {
                $0.edges.equalToSuperview()
            }
        }

        child.didMove(toParent: self)
    }

    func add(_ child: UIViewController, to view: UIView, makeConstraints: (ConstraintMaker) -> Void) {
        addChild(child)
        view.addSubview(child.view)
        child.view.snp.makeConstraints { makeConstraints($0) }
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else { return }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
