//
//  KeychainManager.swift
//  Data
//
//  Created by ali alaa on 01/02/2025.
//

import Foundation
import Security

/// I go with struct as more functional approach
/// In other scenarios I may go with final class and singleton but it will require confirm of Sendable
/// for swift concurrency thread safe as singleton will be accessed from multiple threads which lead to race condition
/// and for simple task I would go easy with confirmation of sendable or the obsessed of declare @unchecked Sendable which will tell
/// compiler don't worry I'm take care of it
/// Final approach is to go with actor for concurrency safety, but it is overhead to use on Keychain, as Keychain framework API is already sync
struct KeychainManager {
    
    // MARK: - init
    /// for production and real token in real world situation
    /// I wont go with this approach of init in struct and call storeToken func
    /// In real world situation I will get the token through API call and call keychain saveToken func
    /// with update its parameters to take the token value
    private init() {
        do {
            try storeToken()
        } catch { }
    }
    
    // MARK: - Methods
    private func storeToken() throws {
        let key = "authToken"
        
        if try KeychainManager.getToken(for: key) == nil {
            let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZmRmNzFkMWEyNmEzYWYxY2I1NWIwZjJjMmRjMWQwMyIsIm5iZiI6MTczODI0MDQyMi42NzcsInN1YiI6IjY3OWI3MWE2MDRjOGRjMzQ3Y2ZiZGMzZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NAc77J7KOcqLKFwV0HNCqDETFa0xAzq3l9M78Zur2Ws"
            saveToken(for: key, value: token)
        }
    }
    
    private func saveToken(for key: String, value: String) {
        let data = value.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            print("DEBUG: Token successfully stored in Keychain")
        } else {
            print("DEBUG: Failed to store token in Keychain")
        }
    }
    
    static func getToken(for key: String) throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "com.tool.banquemisr.challenge05.banquemisr-challenge05",
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess,
           let data = item as? Data,
           let value = String(data: data, encoding: .utf8) {
            return value
        } else if status == errSecItemNotFound {
            return nil
        } else {
            throw KeychainError.unhandledError(status: status)
        }
    }
}
