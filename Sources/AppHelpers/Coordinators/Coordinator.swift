//
//  Coordinator.swift
//  
//
//  Created by Yaroslav Babalich on 19.04.2022.
//

import UIKit

public protocol CoordinatorDelegate: AnyObject {
    func coordinatorDidStart(_ coordinator: Coordinator)
    func coordinatorDidFinish(_ coordinator: Coordinator)
}

public protocol CoordinatorProtocol {
    func start()
    func finish()
}

open class Coordinator: NSObject, CoordinatorProtocol {

    // MARK: - Public properties

    public weak var delegate: CoordinatorDelegate?
    public var isPresented: Bool = false

    // MARK: - Public methods

    open func start() {
        isPresented = true
        delegate?.coordinatorDidStart(self)
    }

    open func finish() {
        isPresented = false
        delegate?.coordinatorDidFinish(self)
    }
}
