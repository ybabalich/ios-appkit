//
//  MPVolumeView+Utilities.swift
//  
//
//  Created by Yaroslav Babalich on 30.05.2021.
//

import MediaPlayer

extension MPVolumeView {

    public static var volume: Float {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

        return slider?.value ?? 0
    }

    public static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}
