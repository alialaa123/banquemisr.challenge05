//
//  MovieDetailsRepository.swift
//  Domain
//
//  Created by ali alaa on 03/02/2025.
//

public protocol MovieDetailsRepository {
    func getMovieDetails(with movieID: Int) async throws -> Movie
}
