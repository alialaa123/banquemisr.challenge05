//
//  GetMovieDetailsUseCase.swift
//  Domain
//
//  Created by ali alaa on 03/02/2025.
//

public protocol GetMovieDetailsUseCase {
    func execute(with movieID: Int) async throws -> Movie
}

public final class DefaultGetMovieDetailsUseCase: GetMovieDetailsUseCase {
    // MARK: - Properties
    private let repository: MovieDetailsRepository
    
    // MARK: - Life cycle
    public init(repository: MovieDetailsRepository) {
        self.repository = repository
    }
    
    // MARK: - Methods
    public func execute(with movieID: Int) async throws -> Movie {
        return try await repository.getMovieDetails(with: movieID)
    }
}
