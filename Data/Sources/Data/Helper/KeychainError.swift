//
//  KeychainError.swift
//  Data
//
//  Created by ali alaa on 01/02/2025.
//

import Foundation

enum KeychainError: Error {
    case unhandledError(status: OSStatus)
}
