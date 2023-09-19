//
//  SKProduct+LocalizedPrice.swift
//  
//
//  Created by Yaroslav Babalich on 09.11.2022.
//

import Foundation
import StoreKit

extension SKProduct {

    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    var isFree: Bool { price == 0.00 }

    public var localizedPrice: String {
        let formatter = SKProduct.formatter
        formatter.locale = priceLocale

        guard !isFree else { return formatter.string(from: 0.0) ?? "" }

        return formatter.string(from: price) ?? ""
    }

}
