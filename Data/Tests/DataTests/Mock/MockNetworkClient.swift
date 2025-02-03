//
//  MockNetworkClient.swift
//  Data
//
//  Created by ali alaa on 04/02/2025.
//

import NetworkLayer
import Domain
@testable import Data

class MockNetworkClient: NetworkClient {
    var sendResult: Result<ListOfMoviesResponseDTO, Error> = .success(
        ListOfMoviesResponseDTO(page: 1, results: [])
    )
    
    var lastRequest: Any?
    
    func send<T: APIRequest>(_ request: T) async throws -> T.Response {
        // Store the last request for verification
        lastRequest = request
        
        // Return mock result
        switch sendResult {
        case .success(let response):
            return response as! T.Response
        case .failure(let error):
            throw error
        }
    }
    
}
