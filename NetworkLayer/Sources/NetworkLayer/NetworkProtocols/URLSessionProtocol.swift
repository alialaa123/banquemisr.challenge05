//
//  URLSessionProtocol.swift
//  NetworkLayer
//
//  Created by ali alaa on 02/02/2025.
//

import Foundation

/// To test APIClient I will need URLSession to depend on Protocol-Oriented design
/// so in test, I can swipe to use MockURLSession
public protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
