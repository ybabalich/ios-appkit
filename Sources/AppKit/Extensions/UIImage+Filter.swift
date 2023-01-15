//
//  UIImage+Filter.swift
//  
//
//  Created by Yaroslav Babalich on 22.02.2022.
//

import UIKit

extension UIImage {

    public enum FilterType : String {
        case chrome = "CIPhotoEffectChrome"
        case fade = "CIPhotoEffectFade"
        case instant = "CIPhotoEffectInstant"
        case mono = "CIPhotoEffectMono"
        case noir = "CIPhotoEffectNoir"
        case process = "CIPhotoEffectProcess"
        case tonal = "CIPhotoEffectTonal"
        case transfer =  "CIPhotoEffectTransfer"
    }

    public func generate(with filter : FilterType) -> UIImage {
        let filter = CIFilter(name: filter.rawValue)

        let ciInput = CIImage(image: self)
        filter?.setValue(ciInput, forKey: "inputImage")

        let ciOutput = filter?.outputImage

        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        return UIImage(cgImage: cgImage!)
    }
}
