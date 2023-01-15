//
//  TimeInterval+Formatter.swift
//  
//
//  Created by Yaroslav Babalich on 30.05.2021.
//

import Foundation

extension TimeInterval {

    public var formattedString: String {
        var miliseconds = self.round(to: 1) * 10
        miliseconds = miliseconds.truncatingRemainder(dividingBy: 10)
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d.%.f", minutes, seconds, miliseconds)
    }
}

extension Double {

    public var formattedTimeString: String {
        var miliseconds = self.round(to: 1) * 10
        miliseconds = miliseconds.truncatingRemainder(dividingBy: 10)
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d.%.f", minutes, seconds, miliseconds)
    }
}
