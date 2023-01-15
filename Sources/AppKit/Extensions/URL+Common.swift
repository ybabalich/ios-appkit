//
//  URL+Common.swift
//  
//
//  Created by Yaroslav Babalich on 29.04.2021.
//

import Foundation
import UIKit

extension URL {
    static public func checkPath(_ path: String) -> Bool {
        let isFileExist = FileManager.default.fileExists(atPath: path)
        return isFileExist
    }

    static public func documentsPath(forFileName fileName: String) -> URL? {
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let writePath = URL(string: documents)!.appendingPathComponent(fileName)

        var directory: ObjCBool = ObjCBool(false)
        if FileManager.default.fileExists(atPath: documents, isDirectory: &directory) {
            return directory.boolValue ? writePath : nil
        }
        return nil
    }

    public func openInBrowser() {
        UIApplication.shared.open(self, options: [:], completionHandler: nil)
    }
}
