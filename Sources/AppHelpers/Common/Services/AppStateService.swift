//
//  AppStateService.swift
//  
//
//  Created by Yaroslav Babalich on 22.01.2021.
//

#if canImport(UIKit)
import UIKit

public enum ApplicationState {
    case willEnterForeground
    case didEnterBackground
    case didBecomeActive
    case willTerminate
}

public protocol AppStateServiceDelegate: AnyObject {
    func appStateServiceDidUpdateState(_ newState: ApplicationState)
}

open class AppStateService {

    // MARK: - Public variables

    public weak var delegate: AppStateServiceDelegate?

    public private(set) var isActiveApp: Bool = true

    // MARK: - Initiliazers

    public init() {
        subscribeToApplicationStateEvents()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Private methods

    private func subscribeToApplicationStateEvents() {

        NotificationCenter.default.addObserver(
            self, selector: #selector(applicationDidEnterBackground(_:)),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self, selector: #selector(applicationWillEnterForeground(_:)),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self, selector: #selector(applicationDidBecomeActive(_:)),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self, selector: #selector(applicationWillTerminate(_:)),
            name: UIApplication.willTerminateNotification,
            object: nil
        )
    }

    // MARK: - Events

    @objc
    private func applicationDidEnterBackground(_ notification: Notification) {
        isActiveApp = false
        delegate?.appStateServiceDidUpdateState(.didEnterBackground)
    }

    @objc
    private func applicationWillEnterForeground(_ notification: Notification) {
        isActiveApp = true
        delegate?.appStateServiceDidUpdateState(.willEnterForeground)
    }

    @objc
    private func applicationDidBecomeActive(_ notification: Notification) {
        isActiveApp = true
        delegate?.appStateServiceDidUpdateState(.didBecomeActive)
    }

    @objc
    private func applicationWillTerminate(_ notification: Notification) {
        isActiveApp = true
        delegate?.appStateServiceDidUpdateState(.willTerminate)
    }
}
#endif
