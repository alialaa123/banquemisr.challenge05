//
//  MockURLSession.swift
//  NetworkLayer
//
//  Created by ali alaa on 02/02/2025.
//

import Foundation
@testable import NetworkLayer

class MockURLSession: URLSessionProtocol {
    var nextData: Data?
    var nextResponse: URLResponse?
    var nextError: Error?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = nextError {
            throw error
        }
        guard let data = nextData,
              let response = nextResponse else {
            throw NetworkError.noData
        }
        return (data, response)
    }
}
