//
//  AVMutableCompositionTrack+Utilities.swift
//  
//
//  Created by Yaroslav Babalich on 30.05.2021.
//

import AVFoundation

extension AVMutableCompositionTrack {

    // returns record duration
    public func append(url: URL) -> Double {
        let newAsset = AVURLAsset(url: url)
        let range = CMTimeRangeMake(start: .zero, duration: newAsset.duration)
        let end = timeRange.end
        if let track = newAsset.tracks(withMediaType: .audio).first {
            try! insertTimeRange(range, of: track, at: end) //swiftlint:disable:this force_try
        }

        return newAsset.duration.seconds
    }
}
