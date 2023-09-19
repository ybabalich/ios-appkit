//
//  BaseWireframe.swift
//  
//
//  Created by Yaroslav Babalich on 19.04.2022.
//

import UIKit

public protocol WireframeInterface: AnyObject {
    associatedtype Controller: UIViewController

    var viewController: Controller { get }
    var navigationController: UINavigationController? { get }
}

open class BaseWireframe<Controller>: WireframeInterface where Controller: UIViewController {

    // MARK: - Public properties

    public var viewController: Controller {
        defer { temporaryStoredViewController = nil }
        return _viewController
    }

    public var navigationController: UINavigationController? {
        return viewController.navigationController
    }

    // MARK: - Private properties

    private unowned var _viewController: Controller
    private var temporaryStoredViewController: Controller?

    // MARK: - Initializers

    public init(viewController: Controller) {
        temporaryStoredViewController = viewController
        _viewController = viewController
    }
}

extension UIViewController {

    public func presentWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>,
                                                 animated: Bool = true,
                                                 completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}

extension UINavigationController {

    public func pushWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>,
                                              animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }

    public func setRootWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>,
                                                 animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
}

