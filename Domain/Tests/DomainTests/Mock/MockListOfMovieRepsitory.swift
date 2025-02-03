//
//  MockListOfMoviesRepository.swift
//  Domain
//
//  Created by ali alaa on 03/02/2025.
//

@testable import Domain

class MockListOfMoviesRepository: ListOfMoviesRepository {
    var getListOfMoviesResult: Result<[Movie], Error> = .success([])
    
    // MARK: - Properties to track
    var listMoviesType: String?
    var lastPage: Int?
     
    // MARK: - Method
    func getListOfMovies(
        with listType: String,
        page: Int
    ) async throws -> [Movie] {
        // Store the properties
        listMoviesType = listType
        lastPage = page
        
        // Return mock result
        return try getListOfMoviesResult.get()
    }
}
