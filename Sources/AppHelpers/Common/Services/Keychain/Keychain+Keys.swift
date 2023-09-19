//
//  Keychain+Keys.swift
//  
//
//  Created by Yaroslav Babalich on 21.01.2021.
//

import KeychainAccess

public extension KeychainKey {
    static let holdingData: String = "holdingDataKey"
    static let accessToken: String = "accessTokenIdentifier"
    static let environmentIdentifier: String = "environmentIdentifier"
    static let refreshToken: String = "refreshTokenIdentifier"
    static let deviceToken: String = "deviceTokenIndetifier" // push notifications token

    static let lockPasscode: String = "deviceLockPasscode"
    static let isPasscodeTurnedOn: String = "isPasscodeTurnedOn"
}

public extension KeychainStorage {
    static let adminUserData: String = "com.flynorthamerica.fly.keychain.admin.user.data"
    static let userData: String = "com.flynorthamerica.fly.keychain.user.data"
    static let passcode: String = "com.flynorthamerica.fly.keychain.passcode"
}
