//
//  InsertMoviesIntoCachingRepository.swift
//  Domain
//
//  Created by ali alaa on 04/02/2025.
//

public protocol InsertMoviesIntoCachingRepository {
    func insertMovies(movies: [Movie]) async throws
}
