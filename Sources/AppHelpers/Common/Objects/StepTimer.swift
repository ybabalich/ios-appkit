//
//  StepTimer.swift
//  
//
//  Created by Yaroslav Babalich on 04.03.2021.
//

import Foundation
import UIKit

public protocol TimerDelegate: AnyObject {
    func timerDidChangeStepsCount(_ stepsCount: Int, isFinished: Bool)
}

public protocol TimerProtocol {
    var delegate: TimerDelegate? { get set }
    var stepsCount: Int { get }
    var isLive: Bool { get }
    var isPaused: Bool { get }
    var milliseconds: Double { get }

    /// To start timer use this method
    func start(interval: TimeInterval, duration: TimeInterval)

    /// Change timeinterval and duration in live
    func setInLiveData(timeInterval: TimeInterval, duration: Double)

    func setStepsCount(_ stepsCount: Int)

    /// To pause timer use this method
    func pause()

    /// To resume timer use this method
    func resume()

    /// To finish timer use this method
    func stop()
}

open class StepTimer: TimerProtocol {

    // MARK: - Public properties

    public weak var delegate: TimerDelegate?
    public private(set) var stepsCount: Int = 0
    public var isLive: Bool { timer != nil && !isPaused }
    public private(set) var isPaused: Bool = false

    public var milliseconds: Double {
        guard let lastStartDate = lastStartDate else { return 0 }

        var seconds = secondsFromTheBeginning

        if let lastStopDate = lastStopDate {
            seconds += lastStopDate.timeIntervalSince(lastStartDate)
        } else {
            seconds += Date().timeIntervalSince(lastStartDate)
        }

        return seconds * 1000
    }

    // MARK: - Private properties

    private var lastStartDate: Date?
    private var lastStopDate: Date?
    private var timer: Timer?
    private var timeInterval: TimeInterval = 0
    private var duration: TimeInterval = 0
    private var secondsFromTheBeginning: Double = 0

    // MARK: - Initializers

    public init() { }

    // MARK: - Public methods

    public func start(interval: TimeInterval, duration: TimeInterval = .infinity) {
        stepsCount = 0
        self.timeInterval = interval
        self.duration = duration
        self.isPaused = false
        self.secondsFromTheBeginning = 0
        self.lastStartDate = Date()
        self.lastStopDate = nil

        stop()

        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self,
                                     selector: #selector(timerStep),
                                     userInfo: nil,
                                     repeats: true)

        RunLoop.current.add(timer!, forMode: .common)

        delegate?.timerDidChangeStepsCount(stepsCount, isFinished: false)
    }

    public func pause() {
        guard let timer = timer else { return }

        isPaused = true
        secondsFromTheBeginning += Date().timeIntervalSince(lastStartDate.required())

        if timer.isValid {
            timer.invalidate()
            self.timer = nil
        }
    }

    public func resume() {
        guard isPaused else { return }

        isPaused = false
        lastStartDate = Date()

        self.timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                          target: self,
                                          selector: #selector(timerStep),
                                          userInfo: nil,
                                          repeats: true)

        RunLoop.current.add(timer!, forMode: .common)
    }

    public func stop() {
        guard let timer = timer else { return }

        lastStopDate = Date()

        if timer.isValid {
            timer.invalidate()
            self.timer = nil
        }
    }

    public func setInLiveData(timeInterval: TimeInterval, duration: Double) {
        self.timeInterval = timeInterval
        self.duration = duration

        stop()

        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self,
                                     selector: #selector(timerStep),
                                     userInfo: nil,
                                     repeats: true)

        RunLoop.current.add(timer!, forMode: .common)
    }

    public func setStepsCount(_ stepsCount: Int) {
        self.stepsCount = stepsCount
        self.secondsFromTheBeginning = 0
        self.lastStartDate = nil
        self.lastStopDate = nil
    }

    // MARK: - Private methods

    @objc
    private func timerStep() {
        stepsCount += 1

        if duration != .infinity {
            let totalSteps = duration / timeInterval

            if TimeInterval(stepsCount) >= totalSteps {
                delegate?.timerDidChangeStepsCount(stepsCount, isFinished: true)
                stop()
            } else {
                delegate?.timerDidChangeStepsCount(stepsCount, isFinished: false)
            }
        } else {
            delegate?.timerDidChangeStepsCount(stepsCount, isFinished: false)
        }
    }
}
