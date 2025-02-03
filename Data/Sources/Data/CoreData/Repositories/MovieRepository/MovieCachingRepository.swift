//
//  MovieCachingRepository.swift
//  Data
//
//  Created by ali alaa on 02/02/2025.
//

import Foundation
import CoreData
import Domain

public protocol MovieCachingRepository {
    func fetchMovies() async throws -> [Movie]
    func insertMovies(movies: [Movie]) async throws
}

public final class DefaultMovieCachingRepository: Sendable, MovieCachingRepository {
    // MARK: - Properties
    private let coreDataManager = CoreDataManager.shared
    
    // MARK: - Life cycle
    public init() { }
    
    // MARK: - Methods
    public func fetchMovies() async throws -> [Movie] {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let movies = try await coreDataManager.fetch(request)
        let moviesDTO = movies.map { $0.toMovieDTO() }
        return moviesDTO.map {
            $0.toDomain()
        }
    }

    public func insertMovies(movies: [Movie]) async throws {
        guard try await shouldInsertMovie() else { return }
        for movie in movies {
            guard let movieEntity: MovieEntity = try await coreDataManager.insert(MovieEntity.self) else {
                return
            }
            _ = movieEntity.toManagedObject(context: movie)
        }
        try await coreDataManager.save()
    }
    
    private func shouldInsertMovie() async throws -> Bool {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let movies = try await coreDataManager.fetch(request)
        return movies.isEmpty
    }
}
