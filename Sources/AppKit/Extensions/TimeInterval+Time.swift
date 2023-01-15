//
//  TimeInterval+Time.swift
//  Gridcap
//
//  Created by Yaroslav Babalich on 09.03.2022.
//

import Foundation

public extension TimeInterval {

    static func minutes(_ amount: Double) -> TimeInterval { 60.0 * amount }
    static func hours(_ amount: Double) -> TimeInterval { Self.minutes(60) * amount }
    static func days(_ amount: Double) -> TimeInterval { Self.hours(24) * amount }
    static func weeks(_ amount: Double) -> TimeInterval { Self.days(7) * amount }
}
