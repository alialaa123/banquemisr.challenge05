//
//  MockCachingRepository.swift
//  Domain
//
//  Created by ali alaa on 04/02/2025.
//

@testable import Domain

class MockCachingRepository: GetListOfMoviesCachingRepository, InsertMoviesIntoCachingRepository {
    var getListOfMoviesResult: Result<[Movie], Error> = .success([])
    
    // MARK: - Method
    func fetchMovies() async throws -> [Movie] {
        return try getListOfMoviesResult.get()
    }
    
    func insertMovies(movies: [Movie]) async throws {
        
    }
}
