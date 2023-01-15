//
//  DelayObject.swift
//  
//
//  Created by Yaroslav Babalich on 09.10.2021.
//

import Foundation

public class DelayObject {

    // MARK: - Variables private

    private var _timer: Timer?
    private let interval: TimeInterval

    // MARK: - Initialiezers

    public init(delayInterval: TimeInterval) {
        interval = delayInterval
    }

    // MARK: - Public methods

    public func addOperation(completion: @escaping EmptyClosure) {
        stopAllOperations()

        _timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: { _ in
            completion()
        })
    }

    public func stopAllOperations() {
        _timer?.invalidate()
    }
}
