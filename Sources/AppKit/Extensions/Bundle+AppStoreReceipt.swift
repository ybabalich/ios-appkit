//
//  Bundle+Bundle+AppStoreReceipt.swift
//  
//
//  Created by Yaroslav Babalich on 16.11.2022.
//

import Foundation

extension Bundle {

    public static func generateAppStoreReceiptBase64String() -> String? {
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
            FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {

            do {
                let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                let receiptString = receiptData.base64EncodedString(options: [])
                return receiptString
            } catch { return nil }
        }

        return nil
    }

}
