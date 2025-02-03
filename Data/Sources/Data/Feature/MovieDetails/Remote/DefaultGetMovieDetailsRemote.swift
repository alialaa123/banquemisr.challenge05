//
//  File.swift
//  Data
//
//  Created by ali alaa on 03/02/2025.
//

import Foundation
import Domain
import NetworkLayer

public final class DefaultGetMovieDetailsRemote: MovieDetailsRepository {
    // MARK: - Properties
    private let client: NetworkClient
    
    // MARK: - Life cycle
    public init(client: NetworkClient) {
        self.client = client
    }
    
    // MARK: - Methods
    public func getMovieDetails(with movieID: Int) async throws -> Movie {
        let token = try KeychainManager().getToken(for: "authToken") ?? ""
        let request = MovieDetailsRequest(
            path: "\(movieID)",
            authToken: token
        )
        let MovieDetailsResponseDTO = try await client.sendWithRetry(request)
        return MovieDetailsResponseDTO.toDomain()
    }
}
