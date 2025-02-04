//
//  GetListOfMoviesCachingRepository.swift
//  Domain
//
//  Created by ali alaa on 04/02/2025.
//

public protocol GetListOfMoviesCachingRepository {
    func fetchMovies() async throws -> [Movie]
}
