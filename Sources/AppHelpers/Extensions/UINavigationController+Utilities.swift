//
//  UINavigationController+Utilities.swift
//  
//
//  Created by Yaroslav Babalich on 09.02.2021.
//

import UIKit

public extension UINavigationController {

    func removeFromStack(_ screenTypes: [UIViewController.Type]) {
        viewControllers.removeAll { viewController -> Bool in
            screenTypes.contains(where: { $0 == viewController.classForCoder })
        }
    }

    @discardableResult
    func goBackToController<T>(type: T.Type) -> T? {
        var searchController: T?

        if let presentedViewController = presentedViewController {
            presentedViewController.dismiss(animated: true, completion: nil)
        }

        viewControllers.forEach { controller in
            if controller.classForCoder == type {
                searchController = controller as? T
            }
        }

        let navViewControllers = viewControllers

        if let searchController = searchController as? UIViewController,
            let index = navViewControllers.firstIndex(of: searchController) {

            let newViewControllers = Array(navViewControllers[0...index])
            setViewControllers(newViewControllers, animated: true)
        }

        return searchController
    }
}
