//
//  MockKeychainManager.swift
//  Data
//
//  Created by ali alaa on 04/02/2025.
//

import Foundation
@testable import Data

class MockKeychainManager: KeychainManager {
    var getTokenResult: String? = "mockToken"
    
    func getToken(for key: String) throws -> String? {
        return getTokenResult
    }
}
