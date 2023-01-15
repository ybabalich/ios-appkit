//
//  UISliderViewController.swift
//  
//
//  Created by Yaroslav Babalich on 14.11.2021.
//

import UIKit

public protocol UISliderViewControllerDelegate: AnyObject {
    func uiSliderViewControllerDidShowController(at index: Int)
}

open class UISliderViewController<C: UIViewController>: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    // MARK: - Public properties

    public weak var coordinatorDelegate: UISliderViewControllerDelegate?
    public private(set) var selectedController: C

    // MARK: - Private properties

    private(set) var privateControllers: [C]

    // MARK: - Initializers

    public init(controllers: [C]) {
        guard !controllers.isEmpty else {
            fatalError("Controllers should be at least 1")
        }

        self.privateControllers = controllers
        self.selectedController = privateControllers.first! //swiftlint:disable:this force_unwrapping

        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        setupUI()

        setViewControllers(
            [selectedController],
            direction: .forward,
            animated: false,
            completion: nil
        )
    }

    public required init?(coder: NSCoder) {
        fatalError(#function)
    }

    // MARK: - Public methods

    public func showNext() {
        guard let nextVC = nextController(to: selectedController) else { return }

        setViewControllers(
            [nextVC],
            direction: .forward,
            animated: true
        ) { [unowned self] _ in

            selectedController = nextVC
            coordinatorDelegate?.uiSliderViewControllerDidShowController(at: privateControllers.firstIndex(of: nextVC)!) //swiftlint:disable:this force_unwrapping
        }
    }

    public func showPrevious() {
        guard let prevVC = prevController(to: selectedController) else { return }

        setViewControllers([prevVC],
                           direction: .reverse,
                           animated: true) { [unowned self] _ in

            selectedController = prevVC
            coordinatorDelegate?.uiSliderViewControllerDidShowController(at: privateControllers.firstIndex(of: prevVC)!) //swiftlint:disable:this force_unwrapping
        }
    }

    // MARK: - Private properties

    private func setupUI() {
        delegate = self
        dataSource = self
    }

    private func nextController(to viewController: C) -> C? {
        guard let viewControllerIndex = privateControllers.firstIndex(of: viewController) else { return nil }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < privateControllers.count else { return nil }

        guard privateControllers.count > nextIndex else { return nil }

        return privateControllers[nextIndex]
    }

    private func prevController(to viewController: C) -> C? {
        guard let viewControllerIndex = privateControllers.firstIndex(of: viewController) else { return nil }

        let prevIndex = viewControllerIndex - 1

        guard prevIndex >= 0 else { return nil }

        return privateControllers[prevIndex]
    }

    // MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let introVC = viewController as? C else { return nil }

        guard let viewControllerIndex = privateControllers.firstIndex(of: introVC) else { return nil }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else { return nil }

        guard privateControllers.count > previousIndex else { return nil }

        return privateControllers[previousIndex]
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let controller = viewController as? C else { return nil }

        return nextController(to: controller)
    }

    public func pageViewController(_ pageViewController: UIPageViewController,
                                   didFinishAnimating finished: Bool,
                                   previousViewControllers: [UIViewController],
                                   transitionCompleted completed: Bool) {

        guard completed, let presentedVC = pageViewController.viewControllers?.first as? C,
              let presentedIndex = privateControllers.firstIndex(of: presentedVC) else { return }

        selectedController = privateControllers[presentedIndex]
        coordinatorDelegate?.uiSliderViewControllerDidShowController(at: presentedIndex)
    }

    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {

    }
}

extension UIPageViewController {
    public var isPagingEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
}
